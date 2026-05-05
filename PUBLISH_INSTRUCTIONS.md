# Publishing the Divisas.lat Swift SDK

The Swift SDK relies on Swift Package Manager (SPM). Publishing a Swift package does not require uploading to a centralized registry like npm or PyPI. Instead, Swift packages are consumed directly from their Git repository via version tags.

## 1. Prepare for Release
Ensure your codebase is fully tested and all changes are merged into the `main` branch.

## 2. Tag the Release
To publish version `1.0.0`, you simply create a Git tag and push it to the remote repository.

```bash
git tag 1.0.0
git push origin 1.0.0
```

## 3. GitHub Releases (Optional but Recommended)
It is highly recommended to create a release in GitHub for your tag:
1. Go to the repository on GitHub.
2. Click on "Releases" -> "Draft a new release".
3. Choose the tag `1.0.0` you just created.
4. Auto-generate release notes or write them manually.
5. Click "Publish release".

## 4. Usage in Xcode or SPM
Developers can now import your library into their Xcode projects by adding the repository URL:
`https://github.com/divisas-lat/swift-sdk.git`

They can specify `1.0.0` as the exact version or "Up to Next Major Version".
