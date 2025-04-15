const repoName = "flutter_prac";

module.exports = {
  branches: [
    "+([0-9])?(.{+([0-9]),x}).x",
    "main",
    "next",
    "next-major",
    { name: "beta", prerelease: true },
    { name: "alpha", prerelease: true },
  ],
  tagFormat: "v${version}",
  plugins: [
    [
      "@semantic-release/commit-analyzer",
      {
        preset: "angular",
        initialReleaseVersion: "1.0.0",
        releaseRules: [
          { type: "feat", release: "minor" },
          { type: "fix", release: "patch" },
          { type: "docs", release: "patch" },
          { type: "style", release: "patch" },
          { type: "refactor", release: "patch" },
          { type: "perf", release: "patch" },
          { type: "test", release: "patch" },
          { type: "ci", release: "patch" },
          { type: "build", release: "patch" },
          { type: "chore", release: "patch" },
        ],
        parserOpts: {
          noteKeywords: ["BREAKING CHANGE", "BREAKING CHANGES"],
        },
      },
    ],
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    [
      "@semantic-release/npm",
      {
        npmPublish: false,
      },
    ],
    [
      "@semantic-release/git",
      {
        assets: [
          "CHANGELOG.md",
          "package.json",
          "package-lock.json",
          "pubspec.yaml",
        ],
        message:
          "🔖 release: v${nextRelease.version} [skip ci]\n\n📋 Released on ${new Date().toISOString()}\n\n${nextRelease.notes}",
      },
    ],
    [
      "@semantic-release/github",
      {
        assets: [
          { path: `release_assets/${repoName}-*.apk` },
          { path: `release_assets/${repoName}-*.aab` },
          { path: `release_assets/${repoName}-*.dmg` },
          { path: `release_assets/${repoName}-*-linux.tar.gz` },
        ],
      },
    ],
  ],
};
