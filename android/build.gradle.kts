allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    // Helper function to set namespace for isar_flutter_libs
    fun setNamespace() {
        if (project.name == "isar_flutter_libs") {
            try {
                val android = project.extensions.getByName("android")
                val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                setNamespace.invoke(android, "dev.isar.isar_flutter_libs")
                println("Set namespace for isar_flutter_libs")
            } catch (e: Exception) {
                println("Failed to set namespace for isar_flutter_libs: ${e.message}")
            }
        }
    }

    // Helper function to force compileSdkVersion
    fun setCompileSdk() {
        if (project.plugins.hasPlugin("com.android.library") || project.plugins.hasPlugin("com.android.application")) {
            try {
                val android = project.extensions.getByName("android")
                // Try setting compileSdkVersion to 34
                val setCompileSdkVersion = android.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                setCompileSdkVersion.invoke(android, 34)
                println("Forced compileSdkVersion to 34 for ${project.name}")
            } catch (e: Exception) {
                // Try with String if Int fails
                try {
                    val android = project.extensions.getByName("android")
                    val setCompileSdkVersion = android.javaClass.getMethod("setCompileSdkVersion", String::class.java)
                    setCompileSdkVersion.invoke(android, "android-34")
                    println("Forced compileSdkVersion to android-34 for ${project.name}")
                } catch (e2: Exception) {
                    println("Failed to set compileSdkVersion for ${project.name}: ${e2.message}")
                }
            }
        }
    }

    // Apply configurations
    if (project.state.executed) {
        setNamespace()
        setCompileSdk()
    } else {
        project.afterEvaluate {
            setNamespace()
            setCompileSdk()
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
