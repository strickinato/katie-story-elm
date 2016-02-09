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
for at least four months.
    """
  , """
  It was January and I had been going to a lot of spoken-word events, listening to a lot of
lesbian poetry. A lot of this was about squirting: . Fuck yeah. Female ejaculation. This
was something I was trying to practice, though I was finding it pretty hard. Clitoral
orgasm is one thing, but vaginal orgasm, now that, that is something that feels a lot like
pissing your pants. “It’s not gross,” they spat. “It’s milk on toast! It’s siren sod, it’s love
rivulets! It’s all the colors of the rainbow.” Fuck, they were powerful. They knew what
was up, these women. I was listening hard.
    """
  , """
  Enter: Jason Caroll.
    """
  , """
  I met him in this lower division Lit class called Jewish Identity. He wasn’t Jewish but I
was and we liked that; I felt in-the-know and he felt like he had an in. He wore these old-
man hipster glasses; round, beige-colored ones and I wore really big old-woman glasses.
He had a soft voice and squinty eyes, short fingers and small lips. Dressed like a bro(what
do you mean by this? The glasses sound hipster). He couldn’t hold silence and he didn’t
have good friends (love this!).
    """
  , """
Jason had just gotten back to school from this commune in the desert outsidef San Diego,
where he meditated for three hours, three times a day, every day. One time after class, the
day he told me he liked my glasses, we walked into the woods behind campus and I asked
him his thoughts on God. He regally knelt in the redwood dirt and spoke slowly about
The Greater Power. “I don’t take the Lord’s name in vain and I think everything is holy,”
he said. Then we walked to the bus stop.
    """
  , """
Maybe I liked him because it seemed like he was looking for bigger answers. Maybe I
liked him because he was a stranger to me, disconnected from the time before my
mother’s death. Or maybe, I was off.
    """
  , """
One late, wintry afternoon, we were hanging out at my house. Our second date. I made us
a pot of chamomile tea and we talked about our professor, Murray Baumgarten, whom
we both wanted to be our grandfather. We were in my twin’s room because she didn’t
have a roommate. We moved to her bed. Things progressed and he started moving his
short fingers inside my pussy and it felt good. So good that, twenty minutes later, I felt it
happening. I was going to cum. Vaginally. Fuck yeah. I didn’t want to get Erica’s
mattress wet, so I told him “let’s get on the floor.” We lied on the ruggot on the floorgot
on the floor and Jason Caroll kept moving his fingers inside me.
    """
  , """
“Tell me to relax,” I told him.
    """
  ]