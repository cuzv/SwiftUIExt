load("@build_bazel_rules_ios//rules:framework.bzl", "apple_framework")

apple_framework(
    name = "SwiftUIExt",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    platforms = {
        "ios": "13.0",
        "macos": "10.15",
    },
    swift_version = "5.9",
    visibility = [
        "//visibility:public",
    ],
)
