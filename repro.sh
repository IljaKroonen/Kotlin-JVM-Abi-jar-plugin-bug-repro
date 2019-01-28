if [ ! -f kotlin-compiler-1.3.20.zip ]
then
    wget https://github.com/JetBrains/kotlin/releases/download/v1.3.20/kotlin-compiler-1.3.20.zip
fi

if [ ! -d kotlinc ]
then
    unzip kotlin-compiler-1.3.20.zip
fi

./kotlinc/bin/kotlinc KotlinJvmAbiPluginHatesMe.kt -Xplugin=kotlinc/lib/jvm-abi-gen.jar -P plugin:org.jetbrains.kotlin.jvm.abi:outputDir=abiclasses -d classes
