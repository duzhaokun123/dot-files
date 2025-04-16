// 可能加速国内下载 当然也可能更慢

fun RepositoryHandler.enableMirror() {
    all {
        if (this is MavenArtifactRepository) {
            val originalUrl = this.url.toString().removeSuffix("/")
            if (originalUrl.startsWith("failback:")) {
                val newUrl = originalUrl.removePrefix("failback:")
                this.setUrl(newUrl)
                logger.lifecycle("repo $newUrl set as failback")
            } else {
                val newUrl = urlMappings[originalUrl]
                if (newUrl == null) {
                    logger.lifecycle("repo $url keep")
                } else {
                    this.setUrl(newUrl)
                    logger.lifecycle("repo $url mirror to $newUrl")
                    maven("failback:$originalUrl")
                }
            }
        }
    }
}

val urlMappings = mapOf(
    "https://repo1.maven.org/maven2" to "https://maven.aliyun.com/repository/central/",
    "https://repo.maven.apache.org/maven2" to "https://maven.aliyun.com/repository/public/",
    "https://plugins.gradle.org/m2" to "https://maven.aliyun.com/repository/gradle-plugin", 
    "https://jcenter.bintray.com" to "https://maven.aliyun.com/repository/public",
    "https://dl.google.com/dl/android/maven2" to "https://maven.aliyun.com/repository/google", // 过时的
)

gradle.beforeSettings { 
    pluginManagement.repositories.enableMirror()
    dependencyResolutionManagement.repositories.enableMirror()
}