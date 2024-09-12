import 'package:ai_image_generator/prompts/bloc/prompt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();

  final PromptBloc promptBloc = PromptBloc();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // This will allow the body to extend behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "AI IMAGE GENERATOR",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ok.png"), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlocConsumer<PromptBloc, PromptState>(
            bloc: promptBloc,
            listener: (context, state) {},
            builder: (context, state) {
              switch (state.runtimeType) {
                case const (PromptGeneratingImageLoadState):
                  return const Center(child: CircularProgressIndicator());

                case const (PromptGeneratingImageErrorState):
                  return const Center(child: Text("Something went wrong"));

                case const (PromptGeneratingImageSuccessState):
                  final successState =
                      state as PromptGeneratingImageSuccessState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(successState.uint8list),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 240,
                        padding: const EdgeInsets.all(24),
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              cursorColor: Colors.deepPurpleAccent,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Unleash Your Creativity with AI",
                                hintStyle: const TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurpleAccent),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 48,
                              width: double.maxFinite,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.deepPurpleAccent),
                                ),
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    promptBloc.add(
                                      PromptEnteredEvent(
                                          prompt: controller.text),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.token_outlined,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  "Generate",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 240,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 55),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: controller,
                                cursorColor: Colors.deepPurple,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Unleash Your Creativity with AI",
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.deepPurpleAccent),
                                      borderRadius: BorderRadius.circular(12)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 48,
                                width: double.maxFinite,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                        Colors.deepPurple),
                                  ),
                                  onPressed: () {
                                    if (controller.text.isNotEmpty) {
                                      promptBloc.add(PromptEnteredEvent(
                                          prompt: controller.text));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.token_outlined,
                                    color: Colors.black,
                                  ),
                                  label: const Text(
                                    "Generate",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
