package com.academy.healthier

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.ConfigurationPropertiesScan
import org.springframework.boot.runApplication

@SpringBootApplication
@ConfigurationPropertiesScan
class HealthierApplication

fun main(args: Array<String>) {
    runApplication<HealthierApplication>(*args)
}
