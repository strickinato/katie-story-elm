module Model.StoryText where

import Html exposing (text)
import Html.Attributes exposing (id)


presents : Html.Html
presents =
  Html.h2 [id "presents" ] [ text "Otherwheres Presents:" ]


title : Html.Html
title =
  Html.h1 [ id "title" ] [ text "Jason Caroll" ]


byLine : Html.Html
byLine =
  Html.h2 [id "byline" ] [ text "by" ]


author : Html.Html
author =
  Html.h2 [id "author" ] [ text "Katie Wheeler-Dubin" ]


storyText : Html.Html
storyText =
    let
        renderParagraph paragraph =
            Html.p [] [ text paragraph ]
    in
        Html.div
            [ id "story-text" ]
            (List.map renderParagraph storyParts)


storyParts : List String
storyParts =
  [ """
My mom had just died. I was twenty-one. My hair: newly brown. I was back at school in
Santa Cruz after a quarter off. I was trying really hard to be strong. I hadn’t had good sex
in four months.
   """
 , """
It was January and I had been going to a lot of spoken-word events, listening to a lot of
lesbian poetry. A lot of this was about squirting: Female ejaculation. This was something
I was trying to practice, though I was finding it pretty hard. Clitoral orgasm is one thing,
but vaginal orgasm, now that, that is something that feels a lot like pissing your pants.
“It’s not gross,” they spat. “It’s milk on toast! It’s siren sod, it’s love rivulets! It’s all the
colors of the rainbow.” Fuck, they were powerful. They knew what was up, these women.
I was listening hard.
   """
 , """
Enter: Jason Caroll.
I met him in this lower division Lit class called Jewish Identity. He wasn’t Jewish but I
was and we liked that; I felt in-the-know and he felt like he had an in. He wore these old-
man hipster glasses; round, beige-colored ones and I wore really big old-woman glasses.
He had a soft voice and squinty eyes, short fingers and small lips. He couldn’t hold
silence and he didn’t have good friends.
   """
 , """
Jason had just gotten back to school from this commune in the desert outside San Diego,
where he meditated for three hours, three times a day, every day. One time after class, the
day he told me he liked my glasses, we walked into the woods behind campus and I asked
him his thoughts on God. He knelt in the redwood dirt and spoke slowly about The
Greater Power. “I don’t take the Lord’s name in vain and I think everything is holy,” he
said. Then we walked to the bus stop.
   """
 , """
Maybe I liked him because it seemed like he was looking for bigger answers. Maybe I
liked him because he was a stranger to me, disconnected from the time before my
mother’s death. Or maybe I was off.
   """
 , """
One late, wintry afternoon, we were hanging out at my house. Our second date. I made us
a pot of chamomile tea and we talked about our professor, Murray Baumgarten, whom
we both wanted to be our grandfather. We were in my twin’s room because she didn’t
have a roommate. We moved to her bed. Things progressed and he started moving his
short fingers inside my pussy and it felt good. So good that, twenty minutes later, I felt it
happening. I was going to cum. Vaginally. Fuck yeah. I didn’t want to get Erica’s
mattress wet, so I told him “let’s get on the floor.” We got on the floor and Jason Caroll
kept moving his fingers inside me.
   """
 , """
“Tell me to relax,” I told him.
   """
 , """
“Relax,” Jason said. “Relax, Katie, relax.”
   """
 , """
“Oh,” I moaned.
   """
 , """
“Relax, relax,” he said.
   """
 , """
“Oh,” I moaned.
   """
 , """
This went on for a couple of minutes until his hand started to hurt. He withdrew his
fingers and started massaging his wrist. I lay sweat-soaked beside him. “Relax, Katie,” I
told myself. “Let it out, baby,” I whispered.
   """
 , """
“What?” Jason said.
   """
 , """
“Relax. You’re beautiful,” I told myself. “Relax. You’re gonna cum like all the colors of
the rainbow.”
   """
 , """
My ejaculation that afternoon was no glorious spurting extravaganza. It was no riotous
exclamation of pussy power. It was tea-infused slow release. It was a puddle that spread
out slow and creeping across the hardwood floor.
   """
 , """
Jason Caroll stopped his wrist stretches. Jason Caroll started freaking the fuck out.
“Oh my God, you’re peeing, Katie. Shit. You’re peeing, you’re peeing.” Jason scrambled
to his feet.
   """
 , """
“I’m peeing,” I said.
   """
 , """
“You’re peeing all over the floor, you’re peeing all over the fucking floor.” Jason started
frantically looking around the room for a towel, for a shirt, for a rug, anything. Anything
at all.
   """
 , """
“I’m peeing,” I said. “I’m peeing.” I didn’t try to stop.
   """
 , """
“Shit, you’re peeing all over the floor. You’re peeing all over your twin’s floor. Shit.
Shit.” Jason’s eyes cast like bobble-head. His back was against the door and he didn’t
look at my face.
   """
 , """
“I’m peeing,” I said. “I’m peeing. Oh, God.”
   """
 ]
