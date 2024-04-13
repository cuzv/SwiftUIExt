load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "SwiftUIExt",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    data = [
        ":SwiftUIExtResources",
    ],
    module_name = "SwiftUIExt",
    visibility = [
        "//visibility:public",
    ],
)

apple_resource_bundle(
    name = "SwiftUIExtResources",
    bundle_name = "SwiftUIExt",
    resources = glob([
        "Resources/*",
    ]),
)
