import java.time.Duration

fun notInlineFunctionWithLambdaAsParameter(lambda: () -> Int) { lambda() }

fun theKotlinAbiJarPluginDoesNotLikeMe(capturedParam: Int) {
    run {
        notInlineFunctionWithLambdaAsParameter {
            capturedParam
        }
    }
}
