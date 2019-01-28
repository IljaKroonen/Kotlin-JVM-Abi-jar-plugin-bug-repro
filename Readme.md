# Kotlin JVM Abi jar plugin bug repro

## Step

 - Be on linux
 - Clone the repository
 - Run `./repro.sh`

## Expectation

 - The command returns with code 0
 - A classes directory is created and contains compiled classes
 - A abiclasses directory is created and contains ABI classes

## Reality

The compiler crashes with the following output

```
exception: java.lang.IllegalStateException: Backend Internal error: Exception during code generation
Cause: Back-end (JVM) Internal error: Couldn't inline method call 'run' into
public fun theKotlinAbiJarPluginDoesNotLikeMe(capturedParam: kotlin.Int): kotlin.Unit defined in root package in file KotlinJvmAbiPluginHatesMe.kt
fun theKotlinAbiJarPluginDoesNotLikeMe(capturedParam: Int) {
    run {
        notInlineFunctionWithLambdaAsParameter {
            capturedParam
        }
    }
}
Cause: run (Lkotlin/jvm/functions/Function0;)Ljava/lang/Object;:
  @Lkotlin/internal/InlineOnly;() // invisible
   L0
    LINENUMBER 39 L0
    NOP
   L1
    LINENUMBER 42 L1
    ALOAD 0
    INVOKEINTERFACE kotlin/jvm/functions/Function0.invoke ()Ljava/lang/Object; (itf)
    ARETURN
   L2
    LOCALVARIABLE block Lkotlin/jvm/functions/Function0; L0 L2 0
    LOCALVARIABLE $i$f$run I L0 L2 1
    MAXSTACK = 1
    MAXLOCALS = 2

Cause: insnList.first must not be null
File being compiled at position: (6,5) in /home/ilja/Desktop/kotlin_crash_repro/KotlinJvmAbiPluginHatesMe.kt
The root cause was thrown at: Util.kt:40
File being compiled at position: file:///home/ilja/Desktop/kotlin_crash_repro/KotlinJvmAbiPluginHatesMe.kt
The root cause was thrown at: InlineCodegen.kt:128
   at org.jetbrains.kotlin.codegen.CompilationErrorHandler.lambda$static$0(CompilationErrorHandler.java:24)
   at org.jetbrains.kotlin.codegen.PackageCodegenImpl.generate(PackageCodegenImpl.java:74)
   at org.jetbrains.kotlin.codegen.DefaultCodegenFactory.generatePackage(CodegenFactory.kt:97)
   at org.jetbrains.kotlin.codegen.DefaultCodegenFactory.generateModule(CodegenFactory.kt:68)
   at org.jetbrains.kotlin.codegen.KotlinCodegenFacade.doGenerateFiles(KotlinCodegenFacade.java:47)
   at org.jetbrains.kotlin.codegen.KotlinCodegenFacade.compileCorrectFiles(KotlinCodegenFacade.java:39)
   at org.jetbrains.kotlin.jvm.abi.JvmAbiAnalysisHandlerExtension.analysisCompleted(JvmAbiAnalysisHandlerExtension.kt:71)
   at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM$analyzeFilesWithJavaIntegration$2.invoke(TopDownAnalyzerFacadeForJVM.kt:96)
   at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration(TopDownAnalyzerFacadeForJVM.kt:113)
   at org.jetbrains.kotlin.cli.jvm.compiler.TopDownAnalyzerFacadeForJVM.analyzeFilesWithJavaIntegration$default(TopDownAnalyzerFacadeForJVM.kt:82)
   at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:384)
   at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler$analyze$1.invoke(KotlinToJVMBytecodeCompiler.kt:70)
   at org.jetbrains.kotlin.cli.common.messages.AnalyzerWithCompilerReport.analyzeAndReport(AnalyzerWithCompilerReport.kt:107)
   at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyze(KotlinToJVMBytecodeCompiler.kt:375)
   at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.analyzeAndGenerate(KotlinToJVMBytecodeCompiler.kt:357)
   at org.jetbrains.kotlin.cli.jvm.compiler.KotlinToJVMBytecodeCompiler.compileBunchOfSources(KotlinToJVMBytecodeCompiler.kt:258)
   at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:205)
   at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.doExecute(K2JVMCompiler.kt:57)
   at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.java:96)
   at org.jetbrains.kotlin.cli.common.CLICompiler.execImpl(CLICompiler.java:52)
   at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:93)
   at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:71)
   at org.jetbrains.kotlin.cli.common.CLITool.exec(CLITool.kt:39)
   at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMainNoExit(CLITool.kt:204)
   at org.jetbrains.kotlin.cli.common.CLITool$Companion.doMain(CLITool.kt:196)
   at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler$Companion.main(K2JVMCompiler.kt:348)
   at org.jetbrains.kotlin.cli.jvm.K2JVMCompiler.main(K2JVMCompiler.kt)
   at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
   at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
   at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
   at java.lang.reflect.Method.invoke(Method.java:498)
   at org.jetbrains.kotlin.preloading.Preloader.run(Preloader.java:81)
   at org.jetbrains.kotlin.preloading.Preloader.main(Preloader.java:43)
Caused by: org.jetbrains.kotlin.codegen.CompilationException: Back-end (JVM) Internal error: Couldn't inline method call 'run' into
public fun theKotlinAbiJarPluginDoesNotLikeMe(capturedParam: kotlin.Int): kotlin.Unit defined in root package in file KotlinJvmAbiPluginHatesMe.kt
fun theKotlinAbiJarPluginDoesNotLikeMe(capturedParam: Int) {
    run {
        notInlineFunctionWithLambdaAsParameter {
            capturedParam
        }
    }
}
Cause: run (Lkotlin/jvm/functions/Function0;)Ljava/lang/Object;:
  @Lkotlin/internal/InlineOnly;() // invisible
   L0
    LINENUMBER 39 L0
    NOP
   L1
    LINENUMBER 42 L1
    ALOAD 0
    INVOKEINTERFACE kotlin/jvm/functions/Function0.invoke ()Ljava/lang/Object; (itf)
    ARETURN
   L2
    LOCALVARIABLE block Lkotlin/jvm/functions/Function0; L0 L2 0
    LOCALVARIABLE $i$f$run I L0 L2 1
    MAXSTACK = 1
    MAXLOCALS = 2

Cause: insnList.first must not be null
File being compiled at position: (6,5) in /home/ilja/Desktop/kotlin_crash_repro/KotlinJvmAbiPluginHatesMe.kt
The root cause was thrown at: Util.kt:40
   at org.jetbrains.kotlin.codegen.inline.InlineCodegen.throwCompilationException(InlineCodegen.kt:128)
   at org.jetbrains.kotlin.codegen.inline.InlineCodegen.performInline(InlineCodegen.kt:168)
   at org.jetbrains.kotlin.codegen.inline.PsiInlineCodegen.genCallInner(InlineCodegen.kt:691)
   at org.jetbrains.kotlin.codegen.CallGenerator$DefaultImpls.genCall(CallGenerator.kt:113)
   at org.jetbrains.kotlin.codegen.inline.PsiInlineCodegen.genCall(InlineCodegen.kt:672)
   at org.jetbrains.kotlin.codegen.ExpressionCodegen.invokeMethodWithArguments(ExpressionCodegen.java:2491)
   at org.jetbrains.kotlin.codegen.ExpressionCodegen.invokeMethodWithArguments(ExpressionCodegen.java:2434)
   at org.jetbrains.kotlin.codegen.Callable$invokeMethodWithArguments$1.invoke(Callable.kt:41)
   at org.jetbrains.kotlin.codegen.Callable$invokeMethodWithArguments$1.invoke(Callable.kt:13)
   at org.jetbrains.kotlin.codegen.OperationStackValue.putSelector(StackValue.kt:79)
   at org.jetbrains.kotlin.codegen.StackValueWithLeaveTask.putSelector(StackValue.kt:67)
   at org.jetbrains.kotlin.codegen.StackValue.put(StackValue.java:118)
   at org.jetbrains.kotlin.codegen.StackValue.put(StackValue.java:107)
   at org.jetbrains.kotlin.codegen.ExpressionCodegen.putStackValue(ExpressionCodegen.java:375)
   at org.jetbrains.kotlin.codegen.ExpressionCodegen.gen(ExpressionCodegen.java:360)
   at org.jetbrains.kotlin.codegen.ExpressionCodegen.returnExpression(ExpressionCodegen.java:1677)
   at org.jetbrains.kotlin.codegen.FunctionGenerationStrategy$FunctionDefault.doGenerateBody(FunctionGenerationStrategy.java:64)
   at org.jetbrains.kotlin.codegen.FunctionGenerationStrategy$CodegenBased.generateBody(FunctionGenerationStrategy.java:84)
   at org.jetbrains.kotlin.codegen.FunctionCodegen.generateMethodBody(FunctionCodegen.java:678)
   at org.jetbrains.kotlin.codegen.FunctionCodegen.generateMethodBody(FunctionCodegen.java:483)
   at org.jetbrains.kotlin.codegen.FunctionCodegen.generateMethod(FunctionCodegen.java:269)
   at org.jetbrains.kotlin.codegen.FunctionCodegen.generateMethod(FunctionCodegen.java:185)
   at org.jetbrains.kotlin.codegen.FunctionCodegen.gen(FunctionCodegen.java:156)
   at org.jetbrains.kotlin.codegen.MemberCodegen.genSimpleMember(MemberCodegen.java:197)
   at org.jetbrains.kotlin.codegen.PackagePartCodegen.generateBody(PackagePartCodegen.java:95)
   at org.jetbrains.kotlin.codegen.MemberCodegen.generate(MemberCodegen.java:129)
   at org.jetbrains.kotlin.codegen.PackageCodegenImpl.generateFile(PackageCodegenImpl.java:127)
   at org.jetbrains.kotlin.codegen.PackageCodegenImpl.generate(PackageCodegenImpl.java:66)
   ... 31 more
Caused by: java.lang.IllegalStateException: insnList.first must not be null
   at org.jetbrains.kotlin.codegen.optimization.common.InsnSequence.<init>(Util.kt:40)
   at org.jetbrains.kotlin.codegen.inline.MethodInlinerUtilKt.findCapturedFieldAssignmentInstructions(MethodInlinerUtil.kt:114)
   at org.jetbrains.kotlin.codegen.inline.AnonymousObjectTransformer.extractParametersMappingAndPatchConstructor(AnonymousObjectTransformer.kt:423)
   at org.jetbrains.kotlin.codegen.inline.AnonymousObjectTransformer.doTransform(AnonymousObjectTransformer.kt:132)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner$doInline$lambdaInliner$1.handleAnonymousObjectRegeneration(MethodInliner.kt:189)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner$doInline$lambdaInliner$1.anew(MethodInliner.kt:214)
   at org.jetbrains.org.objectweb.asm.commons.InstructionAdapter.visitTypeInsn(InstructionAdapter.java:472)
   at org.jetbrains.org.objectweb.asm.tree.TypeInsnNode.accept(TypeInsnNode.java:77)
   at org.jetbrains.org.objectweb.asm.tree.InsnList.accept(InsnList.java:144)
   at org.jetbrains.org.objectweb.asm.tree.MethodNode.accept(MethodNode.java:792)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:396)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:102)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner.access$doInline(MethodInliner.kt:47)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner$doInline$lambdaInliner$1.visitMethodInsn(MethodInliner.kt:306)
   at org.jetbrains.org.objectweb.asm.tree.MethodInsnNode.accept(MethodInsnNode.java:117)
   at org.jetbrains.org.objectweb.asm.tree.InsnList.accept(InsnList.java:144)
   at org.jetbrains.org.objectweb.asm.tree.MethodNode.accept(MethodNode.java:792)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:396)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:102)
   at org.jetbrains.kotlin.codegen.inline.MethodInliner.doInline(MethodInliner.kt:75)
   at org.jetbrains.kotlin.codegen.inline.InlineCodegen.inlineCall(InlineCodegen.kt:281)
   at org.jetbrains.kotlin.codegen.inline.InlineCodegen.performInline(InlineCodegen.kt:162)
   ... 57 more
```
