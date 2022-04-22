# bemble/sync-readme

[![gh_last_release_svg]][gh_last_release_url]
[![tippin_svg]][tippin_url]

[gh_last_release_svg]: https://img.shields.io/github/v/release/bemble/sync-readme?sort=semver
[gh_last_release_url]: https://github.com/bemble/sync-readme/releases/latest

[tippin_svg]: https://img.shields.io/badge/donate-BuyMeACoffee-ffdd00?logo=buymeacoffee&style=flat
[tippin_url]: https://www.buymeacoffee.com/bemble


> Synchronize `README.md` and description for your Github project to Docker Hub.


# Usage

See [action.yml](action.yml)


## Minimal

If your `user`-name, and the repo path (`slug`) are both the same on Github and Docker Hub, and `README.md` is located at repo's root, it's enough to:

```yaml
steps:
- uses: actions/checkout@v2

- uses: bemble/sync-readme@v1.0.0
  with:
    pass: ${{ secrets.DOCKER_PASS }}
    description: true
```

## All custom

If everything needs to be specified: 

```yaml
steps:
- uses: actions/checkout@v2

- uses: bemble/sync-readme@v1.0.0
  with:
    user: docker-username
    pass: ${{ secrets.DOCKER_PASS }}
    slug: organization/image-name
    readme: ./docker/description.md
    description: A must-have container, that you can't live without.
```

## Docker Hub 2FA

If your Docker Hub account uses software 2FA, you need to pass the TOTP secret:

```yaml
steps:
- uses: actions/checkout@v2

- uses: bemble/sync-readme@v1.0.0
  with:
    pass: ${{ secrets.DOCKER_PASS }}
    totp_secret: ${{ secrets.DOCKER_TOTP_SECRET }}
    description: true
```

The best way to get your TOTP secret is to disable 2FA and then enable 2FA. The secret is text given in step 2, "Text Code".
Alternatively, your software may display it (for example, with Bitwarden, edit your entry, the secret is at the end of authentication key).

# Notes

1. Add your Docker Hub credentials to "Secrets" section in your repo's settings.
2. Docker Hub requires `user`, and `slug` to be lowercase. Conversion is done automatically for you, so that Github's `userName` becomes `username` when passed to Docker.
3. `description` sets Docker Hub short description to its literal content in all cases, except when it's set to `true`, when Github repo description is used instead.  When skipped, no change is made to Docker Hub description.
4.  `main` branch may sometimes be broken, or change behavior. It's highly recommended to always use [tags].

[tags]: https://github.com/bemble/sync-readme/tags

# License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
