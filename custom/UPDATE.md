# Weekly update: real Hermes -> your `my-hermes` branch

Run everything from the repo folder:

    cd ~/.hermes/hermes-agent

Branches: `main` mirrors the real Hermes (`upstream`). `my-hermes` is yours
(FRYHiTE branding). Never edit `main`. Do not use `hermes update` for this
routine: it targets `main` and can switch you off `my-hermes`.

## 0. Before you start

    git status --short

Commit or stash anything you changed. Untracked files (e.g. `assets/*.jpg`)
make `hermes update` think the tree is dirty, so keep them out of the repo.
Close the Hermes desktop app and any `hermes` sessions.

## 1. Sync `main` with upstream

    git fetch upstream
    git checkout main
    git merge --ff-only upstream/main

`--ff-only` fails if `main` was ever edited. If it fails, stop and ask for
help; do not force it. Optional backup of the mirror: `git push origin main`.

## 2. Merge `main` into `my-hermes`

    git checkout my-hermes
    git tag pre-update-$(date +%Y%m%d)     # restore point
    git merge main

Clean merge, no conflict message: go to step 4.

## 3. Fix conflicts (only if step 2 reported any)

    git status                              # files marked "both modified"

Your changes live in:
- `apps/desktop/src/components/chat/intro.tsx` (FRYHiTE text; open the file, keep
  `const WORDMARK = 'FRYHiTE'` and the `normal-case!` + `width` props on `<Wordmark>`,
  take upstream's changes everywhere else)
- images: `apps/desktop/public/nous-girl*.png`, `apps/desktop/assets/icon*`
  (keep yours: `git checkout --ours <file>`)

After editing each file:

    git add <file>
    git commit            # once all conflicts are resolved

Cannot resolve it? Undo everything and try again another day:

    git merge --abort

(or, after a finished bad merge: `git reset --hard pre-update-YYYYMMDD`).

## 4. Test that the agent runs

    hermes pm repair                        # only if dependencies changed / it complains
    hermes doctor
    hermes chat -q "reply with the single word OK"

Then rebuild and open the desktop app:

    hermes desktop --build-only --force-build
    # launch from your app launcher; check the FRYHiTE text on a new chat

If something is broken: `git reset --hard pre-update-YYYYMMDD`, rebuild.

## 5. Back it up

    git push origin my-hermes
