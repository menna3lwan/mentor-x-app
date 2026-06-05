# Parent App — Mock-Only Features Matrix

Generated as part of Priority 2 (Production Mode Readiness).

This document lists every Parent feature that, in production mode, will
either return empty data or silently fall back to a graceful default because
the backend (EduCore) does not yet expose an equivalent endpoint. The Mock
repositories continue to provide rich placeholder data for development.

For each entry, "Production status" describes what the user will see when the
app is built with `*_REPOSITORY_MODE=prod` and the live backend is reachable.

---

## Authentication

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Password-based parent login | UI accepts password, then auto-routes to OTP | Backend only exposes `POST /api/parent/start-login` + `POST /api/parent/complete-login` | Backend: add password login OR Frontend: drop password field |
| Parent self-registration | Calls `/api/parent/register` and surfaces a localized "registration failed" toast on 404/405 | No backend endpoint | Backend: design and expose registration endpoint |
| `find-student` during registration | Same as above (404 surface as `studentNotFound`) | No backend endpoint | Backend: add /api/parent/lookup-student or similar |

## Children Management

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Link new child (`POST /api/parent/link-child`) | 404 → `ChildrenFailureKind.unknown` | No backend endpoint | Backend: expose link-child |
| Unlink child (`DELETE /api/parent/children/{id}`) | 404 silently swallowed | No backend endpoint | Backend: expose unlink |
| Find student by query (Children flow) | 404 → "student not found" surface | No backend endpoint | Same as auth `find-student` |

## Home / Dashboard

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Recent activity feed | Returns empty list on 404; UI shows empty-state | No `/api/parent/dashboard/recent-activity` endpoint | Backend: expose or remove section |
| Active announcements per child | Falls back to `/api/announcements/active` (global) | No per-child variant | Acceptable for now |

## Communication

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Per-child notifications | Falls back to generic `/api/notifications/my` (no child filter) | No per-child endpoint | Acceptable; backend could later add filter param |
| Per-child announcements archive | Falls back to `/api/announcements/active` | No per-child endpoint | Same |
| WhatsApp groups list | Returns empty list on 404 | No backend endpoint | Backend or feature removal |

## Financial / Wallet

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Wallet summary | Uses `/api/wallet/student/{id}` ✅ | Live | None |
| Wallet transactions | Uses `/api/wallet/student/{id}/transactions` ✅ | Live | None |
| Wallet analytics (monthly + breakdown) | Returns empty entity on 404; UI tiles show "no data" | No backend endpoint | Backend: expose analytics |
| Payments list | Returns empty list on 404 | No `/api/parent/children/{id}/payments` endpoint | Backend or use `/api/payment/wallet/transactions` |
| Top-up | Not wired in Parent yet | `POST /api/wallet/top-up` exists but no UI calls it | Priority 3 / 4 feature |

## Grades & Assessments

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Grade summary per child | Empty entity on 404; UI shows "no grades" | No backend endpoint (closest: `/api/analytics/parent/child/{id}/grade-comparison`) | Backend mapping job |
| Grade trend per child | Empty entity on 404 | Same | Same |
| Assessments list per child | Empty list on 404 | No backend endpoint | Backend or remap to analytics |

## Notifications (generic)

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Push token registration (`POST /api/notifications/fcm-token`) | Silently swallowed on 404/405 | No backend endpoint | Backend: expose FCM endpoint |
| Delete notification | Silently swallowed on 404/405 | No backend endpoint | Backend: expose delete |

## Profile

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| View profile | Works via cached user only | App never calls `GET /api/parent/profile` | Frontend: wire to the existing endpoint |
| Edit profile | Not implemented | UI button is a no-op | Priority 4 |
| Upload avatar | Not implemented | UI button is a no-op | Priority 4 |

## Settings

| Feature | Production status | Reason | Action needed |
|---|---|---|---|
| Push toggle | Not persisted | `setState` only | Priority 4 |
| Change password | Not implemented | UI tile is a no-op | Priority 4 |

---

## Summary

Out of **9 repository surfaces** the Parent app exposes:

- 4 surfaces are **fully production-ready**: Home dashboard summary / per-child overview / enrollments / attendance, Children list (read), Notifications generic (read + PATCH), Wallet (summary + transactions).
- 5 surfaces are **partially production-ready**: every endpoint marked above with `API-CONTRACT (KNOWN MISMATCH)` works in mock mode but degrades gracefully in prod.
- 0 surfaces crash in production. All 404 / 405 paths are handled.

This matrix should be the canonical reference when planning Backend-side
work or future Priorities.
