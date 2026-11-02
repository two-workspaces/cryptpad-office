# Deploy and Host CryptPad on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/cryptpad-office?referralCode=sLjDXb&utm_medium=integration&utm_source=button&utm_campaign=cryptpad-office)

[CryptPad](https://cryptpad.org/) is an end-to-end encrypted office suite: documents, spreadsheets, presentations, rich text, kanban, forms and whiteboards, edited together in real time. Everything is encrypted in the browser, so the server stores only data it can't read. This template wires up the two domains CryptPad requires and includes the office editors.

## About Hosting CryptPad

Two services and one volume. **CryptPad** holds the app and all data. **Sandbox** is a small proxy that gives CryptPad its second domain.

- **The sandbox domain is already set up.** CryptPad runs its editors on a separate domain, so a malicious document can't reach your account's keys. It refuses to work without one, which is the usual reason a CryptPad deploy fails. Both addresses are configured for you.
- **Docs, Sheets and Slides included.** The office editors are normally a separate download of about 600 MB. Here they are built into the image, so they work on first open and a redeploy doesn't fetch them again.
- **Nobody can claim your instance.** The first admin needs a generated token, so opening the URL first gets a stranger nothing.
- **Sized for small plans.** One server node per level instead of upstream's two, about 270 MB at idle.

## Common Use Cases

- A private alternative to Google Docs or Microsoft 365, for a team or a family
- Sharing sensitive documents with clients, without the host being able to read them
- Encrypted forms and polls
- Real-time notes, kanban boards and whiteboards

## Dependencies for CryptPad Hosting

- Nothing external. No database: CryptPad stores encrypted files on the volume.

### Deployment Dependencies

- [CryptPad admin installation guide](https://docs.cryptpad.org/en/admin_guide/installation.html)
- [CryptPad on GitHub](https://github.com/cryptpad/cryptpad)

### Implementation Details

**First steps**

1. In the CryptPad service's Variables, open `CRYPTPAD_ADMIN_SETUP_URL`. The same link is in the deploy logs until an admin exists.
2. Create your account. Keep the password safe: it encrypts your data, and **nobody can reset it**.
3. Follow the setup screens. They let you close registration, which you'll want on a private instance. Otherwise anyone with the URL can sign up.

**Storage limits.** New accounts get 50 MB and uploads stop at 20 MB. Raise both in the Admin panel, and grow the volume to match.

**Custom domains.** Add one to each service, then update `CRYPTPAD_ORIGIN` and `CRYPTPAD_SANDBOX_ORIGIN`. The two must stay different. Changing the main domain means links shared earlier stop working.

**Licences.** CryptPad and its office components are AGPL-3.0. Deploying this template accepts the licence terms of the office components, which are installed at build time.

## Why Deploy CryptPad on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying CryptPad on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
