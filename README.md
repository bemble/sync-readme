# meeDamian/sync-readme

[![gh_last_release_svg]][gh_last_release_url]
[![tippin_svg]][tippin_url]

[gh_last_release_svg]: https://img.shields.io/github/v/release/meeDamian/sync-readme?sort=semver
[gh_last_release_url]: https://github.com/meeDamian/sync-readme/releases/latest

[tippin_svg]: https://img.shields.io/badge/donate-lightning-FDD023?logo=bitcoin&style=flat
[tippin_url]: http://btl.to/@meedamian

Github Action to sync `README.md` from Github to Docker Hub

# Usage

See [action.yml](action.yml)


#### Minimal

If your `user`-name, and the repo path (`slug`) are both the same on Github and Docker Hub, and `README.md` is located at repo's root, it's enough to:

```yaml
steps:
- uses: actions/checkout@master

- uses: meeDamian/sync-readme@v1.0.6
  with:
    pass: ${{ secrets.DOCKER_PASS }}
    description: true
```

#### All custom

If everything needs to be specified: 

```yaml
steps:
- uses: actions/checkout@master

- uses: meeDamian/sync-readme@v1.0.6
  with:
    user: docker-username
    pass: ${{ secrets.DOCKER_PASS }}
    slug: organization/image-name
    readme: ./docker/description.md
    description: A must-have container, that you can't live without.
```

#### Docker Hub 2FA

If your Docker Hub account uses software 2FA, you need to pass the TOTP secret:

```yaml
steps:
- uses: actions/checkout@master

- uses: meeDamian/sync-readme@v1.0.7
  with:
    pass: ${{ secrets.DOCKER_PASS }}
    totp_secret: ${{ secrets.DOCKER_TOTP_SECRET }}
    description: true
```

The best way to get your TOTP secret is to disable 2FA and then enable 2FA. The secret is text given in step 2, "Text Code".
Alternatively, your software may display it (for example, with Bitwarden, edit your entry, the secret is at the end of authentication key).

> **NOTE:** Add Docker Hub password to "Secrets" section in your repo's settings.
 
> **NOTE_1:** Docker Hub requires `user`, and `slug` to be lowercase.  Conversion [is done] automatically for you, so that Github's `meeDamian` becomes `meedamian` when passed to Docker.

> **NOTE_2:** `description` sets Docker Hub short description to its literal content in all cases, except when it's set to `true`, when Github repo description is used instead.  When skipped, no change is made to Docker Hub description.

> **NOTE_3:** `master` branch may sometimes be broken, or change behavior.  It's highly recommended to always use [tags].

[is done]: https://github.com/meeDamian/sync-readme/blob/master/entrypoint.sh#L32-L35
[tags]: https://github.com/meeDamian/sync-readme/tags

# License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
