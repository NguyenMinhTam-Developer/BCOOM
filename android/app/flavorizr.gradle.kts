import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.bcoom.dev"
            resValue(type = "string", name = "app_name", value = "Bcoom Dev")
        }
        create("stg") {
            dimension = "flavor-type"
            applicationId = "com.bcoom.stg"
            resValue(type = "string", name = "app_name", value = "Bcoom Staging")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.bcoom.app"
            resValue(type = "string", name = "app_name", value = "Bcoom")
        }
    }
}