# AUD420 Final Assignment
######DIMITRIS THOMOPOULOS TX2020044
&nbsp;

### Introduction
The purpose of this course is a gentle introduction to the world of music programming and interactive sound systems. My end-of-semester assignment is a beginner's level creation made with SuperCollider, which includes many of the basic concepts of this music programming language. I selected a project idea that would be both enjoyable to work on and an effective way to gain some basic experience on this field.

More specifically, I decided to remake the music production of a Greek RnB track named ['PADOU'](https://www.youtube.com/watch?v=7uxLrzaZufk) by [Saske](https://offbeat.gr/artists/saske), originally produced by [Beyond Music](https://www.instagram.com/beyondmusic__/). By choosing to do a remake, I was able to focus more on the capabilities of SuperCollider without having to worry too much about the musical inspiration.
&nbsp;

### Procedure
The process of creating this project wasn't completed in a single stage. In fact, several steps were needed to end up with a work that presents different aspects of sound synthesis and music programming.
&nbsp;
#### 1. Learning
Having zero experience with SuperCollider, I knew I couldn't just open the IDE and expect to simply know what I would be doing. I had to start learning SC from the very beginning, just like anyone would do with a new programming language.

Thus, I started reading the well-known book ['A Gentle Introduction to SuperCollider'](https://scholarcommons.scu.edu/faculty_books/91/) by Bruno Ruviaro, a brilliant guide which was recommended by prof. Zannos [@iani](https://github.com/iani). After reading each chapter, I would open a new file in Virtual Studio Code and copy/paste the code examples of that chapter, along with the comments and explanations. Then, I would experiment with the variables, arguments, values and functions, trying to understand how each of these elements affected the final sound result. You can find all of the guide's notes in the form of .scd files, organized in chapters under the ```SC tutorial notes``` folder of this repository.

Another useful source of learning were two amazing content creators that upload very helpful SuperCollider tutorials on YouTube, [Eli Fieldsteel](https://www.youtube.com/c/elifieldsteel) and [Sound Engraver](https://www.youtube.com/c/SoundEngraver). I would mainly watch their tutorials during the development stage of the project, in order to find solutions or to fully understand a topic that was still vogue to me even after reading the guide.
&nbsp;

#### 2. Prototyping
After a couple of weeks of learning SuperCollider, I felt like it was time to start planning how my remake would sound like. I had to know how the basic structure would look like, the amount and the type of sounds that would be needed and how detailed I could make it sound (in terms of my experience). The most practical way to do this was to insert the original track into FL Studio and start composing the music tune by ear (beat, melody, rhythm, etc.), using sounds from the default libraries of this Digital Audio Workstation program.

![Screenshot of prototyping the melodies in FL Studio](https://raw.githubusercontent.com/dimitris-thomopoulos/AUD420_Coursework_2208/main/melodies-prototype.jpg)

At first, I started making a low-fidelity prototype with FL Studio, which means that I was just writing down the notes of each instrument (bass, guitar & piano) without caring much about the sounds that I would use. Later on, I realized that I could import sounds into SuperCollider, so I decided to choose a couple better-sounding samples: a kick drum, a shaker sample, a percussion and a saw guitar. I didn't want to overuse samples and lose the meaning of this project, but I think that these sounds really improved the final result.

![Screenshot of the completed prototype in FL Studio](https://raw.githubusercontent.com/dimitris-thomopoulos/AUD420_Coursework_2208/main/melodies-and-drums-prototype.jpg)
&nbsp;

#### 3. Development
After having acquired some basic SuperCollider knowledge and knowing which sounds I needed to produce, which to import and the melodies and the drum patterns of the track, it was finally time to start coding the actual project.

The main methodology that I followed during the development stage was trial & error. I would copy/paste some code I'd find online or try reading my notes again, and if something wasn't working, I would try something else. This process can be painful sometimes, but it always works in the long term. Also, I was constantly advising the prototype (which proved to be very useful), in order to track my progress and verify that the sound results were accurate.

I tried to include as many concepts as I could, from using ```Patterns``` and ```SynthDef``` to ```Envelopes``` and multichannel expansion. Defining new synths form scratch wouldn't provide me the results that I needed for this remake, so instead I modified already existing synths, created by other coders in the community, and I adjusted them to my needs. I also imported the sounds found in FL Studio and combined them with the defined synths. The code is separated into six (6) parts with this order: intro, 1st verse, 1st chorus, 2nd verse, 2nd chorus, outro. Useful comments can be found throughout the code that explain what is happening at their respective line (I will also add comments in English).

Finally, I kept testing different ways to make the code more efficient, that is using less lines of code, faster methods and less repetitive declarations. I know that the final result doesn't let much room for experimentation with live coding, but I will keep that idea for a future SC project.
&nbsp;

### Conclusion
As a conclusion, I believe that this project was one of the best ways I could possibly get introduced to the world of SuperCollider, because I combined two of my passions, music production and coding, put the work in and ended up with a result that I'm satisfied with. Of course, I still have tons of new stuff to learn about this exciting field and there are endless possibilities.