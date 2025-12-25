// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "JXRLib",
    products: [
        .library(
            name: "CJXRLib",
            targets: ["CJXRGlue"]
        ),
        .executable(
            name: "JxrDecApp",
            targets: ["JxrDecApp"]
        ),
        .executable(
            name: "JxrEncApp",
            targets: ["JxrEncApp"]
        ),
    ],
    targets: [
        .target(
            name: "CJXRGlue",
            path: ".",
            sources: [
                "image",
                "jxrgluelib",
            ],
            cSettings: [
                .define("__ANSI__"),
                .define("DISABLE_PERF_MEASUREMENT"),
                .headerSearchPath("common/include"),
                .headerSearchPath("image/sys"),
                .headerSearchPath("jxrgluelib"),
            ],
            linkerSettings: [.linkedLibrary("m")],
        ),
        .target(
            name: "CJXRTest",
            dependencies: [.target(name: "CJXRGlue")],
            path: ".",
            sources: ["jxrtestlib"],
            publicHeadersPath: "jxrtestlib",
            cSettings: [
                .define("__ANSI__"),
                .define("DISABLE_PERF_MEASUREMENT"),
                .headerSearchPath("image/sys"),
                .headerSearchPath("jxrgluelib"),
                .headerSearchPath("jxrtestlib"),
            ],
        ),
        .executableTarget(
            name: "JxrDecApp",
            dependencies: [.target(name: "CJXRTest")],
            path: ".",
            sources: ["jxrencoderdecoder/JxrDecApp.c"],
            cSettings: [
                .define("__ANSI__"),
                .define("DISABLE_PERF_MEASUREMENT"),
            ],
            linkerSettings: [.linkedLibrary("m")],
        ),
        .executableTarget(
            name: "JxrEncApp",
            dependencies: [.target(name: "CJXRTest")],
            path: ".",
            sources: ["jxrencoderdecoder/JxrEncApp.c"],
            cSettings: [
                .define("__ANSI__"),
                .define("DISABLE_PERF_MEASUREMENT"),
            ],
            linkerSettings: [.linkedLibrary("m")],
        ),
    ]
)
