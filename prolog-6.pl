:- dynamic yes/1, no/1.

go :- 
    identify(Animal),
    format('The animal is: ~w~n', [Animal]),
    undo.


identify(jaguar)     :- feline, yellow_with_spots, !.
identify(jaguarundi) :- feline, slender_body, solid_color, !.
identify(jackal)     :- canine, scavenger, pointed_ears, !.
identify(jackrabbit) :- mammal, herbivore, very_long_ears, !.
identify(jerboa)     :- mammal, desert_dweller, hops_like_kangaroo, !.
identify(jellyfish)  :- sea_creature, stinging_tentacles, translucent, !.
identify(jay)        :- bird, blue_feathers, noisy, !.
identify(junco)      :- bird, small_size, white_belly, !.
identify(unknown).

feline :- mammal, carnivore, has_claws.
canine :- mammal, carnivore, long_muzzle.
bird :- verify(has_feathers), verify(lays_eggs).
mammal :- verify(has_hair), verify(gives_milk).
sea_creature :- verify(lives_in_water), verify(no_bones).

color :- 
    (verify(is_yellow) -> true ;
     verify(is_blue) -> true ;
     verify(is_brown) -> true ;
     verify(is_gray)).

carnivore :- verify(eats_meat).
herbivore :- verify(eats_plants).
omnivore  :- verify(eats_everything).

yellow_with_spots :- verify(has_yellow_fur), verify(has_spots).
slender_body :- verify(is_slender).
solid_color :- verify(has_one_color_only).
scavenger :- verify(eats_dead_animals).
pointed_ears :- verify(has_pointed_ears).
very_long_ears :- verify(has_extremely_long_ears).
desert_dweller :- verify(lives_in_desert).
hops_like_kangaroo :- verify(moves_by_hopping).
stinging_tentacles :- verify(has_stinging_tentacles).
translucent :- verify(is_see_through).
blue_feathers :- verify(has_bright_blue_feathers).
noisy :- verify(makes_loud_screams).
small_size :- verify(is_smaller_than_a_hand).
white_belly :- verify(has_white_feathers_on_belly).

% Предикати запитань
ask(Question) :-
    format('Does the animal have the following feature: ~w? (y/n) ', [Question]),
    read(Response),
    ( (Response == yes ; Response == y)
      -> assert(yes(Question)) ;
         assert(no(Question)), fail).

verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))).

undo :- retractall(yes(_)), retractall(no(_)).