plugins {
    id("org.springframework.boot") version "2.6.9" apply false
    id("io.spring.dependency-management") version "1.0.11.RELEASE" apply false
    kotlin("jvm") version "1.6.21" apply false
    kotlin("plugin.spring") version "1.6.21" apply false
    kotlin("plugin.jpa") version "1.6.21" apply false
}

allprojects {
    group = "com.wear"
    version = "0.0.1-SNAPSHOT"
    repositories {
        mavenCentral()
    }
}
