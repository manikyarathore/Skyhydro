"""Keep the drone from visibly flying through trees.

The trees in the flood valley are scenery only (no collision, contype 0): the pilot was trained to avoid
buildings and terrain, not trees. Before a flight is shown, simulate.py works out the exact path the drone
and canister will take (a headless dry run, or the recorded replay frames) and removes every tree within a
safety margin of that path from the view. Physics is unchanged because trees never touched anything.
"""
import numpy as np
import mujoco

DRONE_MARGIN = 2.0      # m around the drone
PAYLOAD_MARGIN = 1.2    # m around the hanging canister


class TreeClearance:
    def __init__(self, model):
        self.m = model
        d = mujoco.MjData(model)
        mujoco.mj_forward(model, d)
        groups = {}
        for g in range(model.ngeom):
            n = mujoco.mj_id2name(model, mujoco.mjtObj.mjOBJ_GEOM, g) or ""
            if n.startswith("tree_") and model.geom_type[g] == mujoco.mjtGeom.mjGEOM_MESH:
                groups.setdefault(int(n.split("_")[1]), []).append(g)
        self.ids, lo, hi, self.body = [], [], [], []
        for i, gs in groups.items():
            vs = []
            for g in gs:
                mid = model.geom_dataid[g]
                a, c = model.mesh_vertadr[mid], model.mesh_vertnum[mid]
                vs.append(model.mesh_vert[a:a + c] @ d.geom_xmat[g].reshape(3, 3).T + d.geom_xpos[g])
            v = np.vstack(vs)
            self.ids.append(i); lo.append(v.min(0)); hi.append(v.max(0)); self.body.append(int(model.geom_bodyid[gs[0]]))
        self.lo, self.hi = np.array(lo).reshape(-1, 3), np.array(hi).reshape(-1, 3)
        self.hidden = set()

    def hits(self, points, margin):
        """Indices of trees whose bounding box, grown by margin, contains any point."""
        P = np.asarray([p for p in points if p is not None], float).reshape(-1, 3)
        out = set()
        for k in range(0, len(P), 2000):
            Q = P[k:k + 2000]
            inside = np.all((Q[:, None, :] >= self.lo[None] - margin) & (Q[:, None, :] <= self.hi[None] + margin), axis=2)
            out |= set(np.flatnonzero(inside.any(axis=0)).tolist())
        return out

    def clear(self, drone_points, payload_points=()):
        """Hide every tree on the given path; returns how many new trees were hidden."""
        idx = self.hits(drone_points, DRONE_MARGIN) | self.hits(payload_points, PAYLOAD_MARGIN)
        new = [k for k in idx if k not in self.hidden]
        for k in new:
            self.m.body_pos[self.body[k]][2] -= 1000.0     # drop the tree far below the terrain
            self.hidden.add(k)
        return len(new)
