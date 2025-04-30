val appModuleName = "test"
val dbModuleName  = "db"
val webapp   = project(":webapp");
val buildDir = layout.buildDirectory.get()
val resourceDir = "${webapp.projectDir}"

tasks.register("clean") {
    group       = "Build"
    description = "Delete previous build results"

    delete(buildDir)
}

tasks.register("build") {
    group       = "Build"
    description = "Build server modules"

    dependsOn(compileAppModule)
}

val compileAppModule = tasks.register("compileAppModule") {
    group       = "Build"
    description = "Compile $appModuleName module"

    dependsOn(compileDbModule)

    doLast {
        val srcModule   = "$projectDir/src/main/x/$appModuleName.x"

        project.exec {
            commandLine("xcc", "--verbose",
                "-o", buildDir,
                "-L", buildDir,
                "-r", resourceDir,
                srcModule)
        }
    }
}

val compileDbModule = tasks.register("compileDbModule") {
    group       = "Build"
    description = "Compile $dbModuleName database module"

    val srcModule = "${projectDir}/src/main/x/$dbModuleName.x"

    project.exec {
        commandLine("xcc", "--verbose",
            "-o", buildDir,
            "-L", buildDir,
            srcModule)
    }
}