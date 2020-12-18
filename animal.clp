(deffacts initial-phase
	(phase choose-size))
	;list of phases saved as facts to transfer between the rules, the use of phases are used.

;size small or big----------------------------------------
(defrule size-select ;This is where the question will be asked
	(phase choose-size) ;states which phase that this is at
	=>
	(printout t "What is the size of the animal (small or big)?") ;prints the question to the user
	(assert (size-select (read))));inserts the input of the user in the size-select fact

(defrule size-small ;the left side of the answer for the above question
	?phase <- (phase choose-size) ;if the phase is coming from the choose-size phase then this will run
	?choice <- (size-select ?size&small);checks the input from user from the fact size-select, in this case it accepts only small
	=>
	(retract ?phase ?choice);receives the phase and choice from the previous question
	(assert (size-select ?size)(phase choose-sound))) ;this moves to the phase choose-sound and inserts the correct size in size-select fact

(defrule size-big ;the right side of the answer for the above question
	?phase <- (phase choose-size) ;checks again the phase if it is coming from choose-size
	?choice <- (size-select ?size&big) ;checks the input from user from the fact size-select, in this case it accepts only big
	=>
	(retract ?phase ?choice);receives the phase and choice from the previous question
	(assert (size-select ?size)(phase choose-neck))) ;for phase it goes to that one of choose-neck and the user input is inserted into the fact size-select
;--------------------------------------------------------
;from this point it is the same general code except for different variables and outcomes to different phases and fact variables different naming.
;sound yes or no-----------------------------------------
(defrule sound-select
	(phase choose-sound)
	=>
	(printout t "Does it squeak (yes or no)?")
	(assert (sound-select (read))))		
	
(defrule sound-yes
	?phase <- (phase choose-sound)
	?choice <- (sound-select ?sound&yes)
	=>
	(retract ?phase ?choice)
	(assert (sound-select ?sound)(animal-Mouse))
	(printout t "Animal Mouse", crlf))

(defrule sound-no
	?phase <- (phase choose-sound)
	?choice <- (sound-select ?sound&no)
	=>
	(retract ?phase ?choice)
	(assert (sound-select ?sound)(phase choose-tail)))
;-----------------------------------------------------------

;tail brushy or small---------------------------------------
(defrule tail-select
	(phase choose-tail)
	=>
	(printout t "Is the tail bushy or Small (bushy or small)?")
	(assert (tail-select (read))))		

(defrule tail-bushy
	?phase <- (phase choose-tail)
	?choice <- (tail-select ?tail&bushy)
	=>
	(retract ?phase ?choice)
	(assert (tail-select ?tail)(animal-Squirrel))
	(printout t "Animal Squirrel", crlf))

(defrule tail-Small
	?phase <- (phase choose-tail)
	?choice <- (tail-select ?tail&small)
	=>
	(retract ?phase ?choice)
	(assert (tail-select ?tail)(animal-Hamster))
	(printout t "Animal Hamster", crlf))
;-----------------------------------------------------------

;neck long or short---------------------------------------
(defrule neck-select
	(phase choose-neck)
	=>
	(printout t "What is the neck size (long or short)?")
	(assert (neck-select (read))))		

(defrule neck-long
	?phase <- (phase choose-neck)
	?choice <- (neck-select ?neck&long)
	=>
	(retract ?phase ?choice)
	(assert (neck-select ?neck)(animal-Giraffe))
	(printout t "Animal Giraffe", crlf))

(defrule neck-short
	?phase <- (phase choose-neck)
	?choice <- (neck-select ?neck&short)
	=>
	(retract ?phase ?choice)
	(assert (neck-select ?neck)(phase choose-nose)))
;-----------------------------------------------------------

;Nose long or short---------------------------------------
(defrule nose-select
	(phase choose-nose)
	=>
	(printout t "What is the size of the nose (long or short)?")
	(assert (nose-select (read))))		

(defrule nose-long
	?phase <- (phase choose-nose)
	?choice <- (nose-select ?nose&long)
	=>
	(retract ?phase ?choice)
	(assert (nose-select ?nose)(animal-Elephant))
	(printout t "Animal Elephant", crlf))

(defrule nose-short
	?phase <- (phase choose-nose)
	?choice <- (nose-select ?nose&short)
	=>
	(retract ?phase ?choice)
	(assert (nose-select ?nose)(phase choose-swims-alot)))
;-----------------------------------------------------------

;SwimsAlot yes or no---------------------------------------
(defrule swims-alot-select
	(phase choose-swims-alot)
	=>
	(printout t "Does it swim a lot (yes or no)?")
	(assert (swims-alot-select (read))))		

(defrule swims-alot-yes
	?phase <- (phase choose-swims-alot)
	?choice <- (swims-alot-select ?swims-alot&yes)
	=>
	(retract ?phase ?choice)
	(assert (swims-alot-select ?swims-alot)(animal-Hippo))
	(printout t "Animal Hippo", crlf))

(defrule swims-alot-no
	?phase <- (phase choose-swims-alot)
	?choice <- (swims-alot-select ?swims-alot&no)
	=>
	(retract ?phase ?choice)
	(assert (swims-alot-select ?swims-alot)(animal-Phino))
	(printout t "Animal Rhino", crlf))
;-----------------------------------------------------------
;at bad choices, all the wrong inputs goes here, this is where it is proccessed.
;bad choices -----------------------------------------------	
(defrule size-badchoice
	?phase <- (phase choose-size) ;if they are coming from that phase it keeps running.
	?choice <- (size-select ?size&~small&~big) ;if the inputs are not small or big then it will continue.
	=>
	(retract ?phase ?choice)
	(assert (phase choose-size)) ;goes to the phase choose-size.
	(printout t "Bad choice, small or big only!", crlf) ;this prints the message stating that this is a bad choice and it only accepts the inputs shown.
	)
	;from this point the rest are the same with the usual different variable namings.
(defrule sound-badchoice
	?phase <- (phase choose-sound)
	?choice <- (sound-select ?sound&~yes&~no)
	=>
	(retract ?phase ?choice)
	(assert (phase choose-sound))
	(printout t "Bad choice, yes or no only!", crlf)
	)
	
(defrule tail-badchoice
	?phase <- (phase choose-tail)
	?choice <- (tail-select ?tail&~bushy&~small)
	=>
	(retract ?phase ?choice)
	(assert (phase choose-tail))
	(printout t "Bad choice, bushy or small only!", crlf)
	)
	
(defrule neck-badchoice
	?phase <- (phase choose-neck)
	?choice <- (neck-select ?neck&~long&~short)
	=>
	(retract ?phase ?choice)
	(assert (phase choose-neck))
	(printout t "Bad choice, long or short only!", crlf)
	)
	
(defrule nose-badchoice
	?phase <- (phase choose-nose)
	?choice <- (nose-select ?nose&~long&~short)
	=>
	(retract ?phase ?choice)
	(assert (phase choose-nose))
	(printout t "Bad choice, long or short only!", crlf)
	)
	
(defrule swims-alot-badchoice
	?phase <- (phase choose-swims-alot)
	?choice <- (swims-alot-select ?swims-alot&~yes&~no)
	=>
	(retract ?phase ?choice)
	(assert (phase choose-swims-alot))
	(printout t "Bad choice, yes or no only!", crlf)
	)
;-----------------------------------------------------------