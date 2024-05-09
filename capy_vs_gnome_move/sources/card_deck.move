module capy_vs_gnome::card_deck {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{Self, utf8, String};
    use std::option::{Self, Option};
    use std::vector;
    use std::hash;
    // use sui::hash;
    use std::debug;
    use sui::clock::{Self, Clock};
    use sui::coin::{Self, TreasuryCap};
    use sui::random::{Self, Random, new_generator};

    use capy_vs_gnome::monsti::{MONSTI, first_turns_mint};

    use capy_vs_gnome::random_funcs::{arithmetic_is_less_than}; 


    #[test_only]
    friend capy_vs_gnome::card_deck_tests_attacks;
    #[test_only]
    friend capy_vs_gnome::card_deck_tests_getters;










    // CONTENTS:
    // PERMENANTS CARDS 
    //   - Card
    //   - delete_card
    // GNOME CARDS
    //   - mint_gnome_general
    //   - transfer_gnome_general
    //   - mint_gnome_monster
    //   - transfer_gnome_monster
    //   - mint_gnome_rider
    //   - transfer_gnome_rider
    //   - mint_gnome_soldier
    //   - transfer_gnome_soldier
    // CAPYBARA CARDS
    //   - mint_capy_general
    //   - transfer_capy_general
    //   - mint_capy_monster
    //   - transfer_capy_monster
    //   - mint_capy_rider
    //   - transfer_capy_rider
    //   - mint_capy_soldier
    //   - transfer_capy_soldier
    // PERMENANTS GETTERS 
    //   - owner_address
    //   - type
    //   - type_id
    //   - name
    //   - image_url
    //   - attack
    //   - defense
    //   - health
    //   - cost
    // INIT
    //   - init
    // MINT DECKS
    //   - mint_gnome_cards
    //   - transfer_gnome_cards
    //   - gnome_deck
    //   - delete_all_gnome_cards
    //   - transfer_capy_cards
    // CONFIRM DECKS
    //   - confirm_deck
    // GAME SETUP
    //    - Game
    //    - TurnKey
    //    - start_game
    //    - turn_trial
    //    - first_turn
    //    - HashedSelection
    //    - HashedSelectionProved
    //    - HashedSelectionMade
    //    - HashedSelectionProvedMade
    //    - hashed_selection
    //    - prove_hashed_selection
    // GAME GETTERS
    //    - player_one_address
    //    - player_two_address
    //   -  coin_flip_guess
    //    - coin_flip_count
    //    - coin_flip_result
    //    - even_turns
    //    - odd_turns
    //    - turn_count
    //    - confirm_deck_player_one
    //    - confirm_deck_player_two
    //    - player_one_general_status
    //    - player_one_monster_status
    //    - player_one_rider_status
    //    - player_one_soldier_status
    //    - player_two_general_status
    //    - player_two_monster_status
    //    - player_two_rider_status
    //    - player_two_soldier_status
    // COIN TOSS FUNCTIONS
    //   - coin_toss
    // ATTACK FUNCTIONS
    //   - soldier_vs_soldier 
    //   - soldier_vs_rider
    //   - soldier_vs_monster
    //   - soldier_vs_general
    //
    //   - rider_vs_soldier 
    //   - rider_vs_rider
    //   - rider_vs_monster
    //   - rider_vs_general
    //
    //   - monster_vs_soldier 
    //   - monster_vs_rider
    //   - monster_vs_monster
    //   - monster_vs_general
    //
    //   - general_vs_soldier 
    //   - general_vs_rider
    //   - general_vs_monster
    //   - general_vs_general
    // DEFENSE FUNCTIONS
    //   - frontline_defense_stance
    //   - backline_defense_stance
    // PROBABILITY FUNCTIONS
    //   - twenty_five_percent_probability
    //   - thirty_three_percent_probability
    //   - forty_percent_probability
    //   - fifty_percent_probability
    //   - fifty_five_percent_probability
    //   - sixty_percent_probability
    //   - sixty_six_percent_probability
    //   - seventy_percent_probability
    //   - seventy_five_percent_probability
    //   - eighty_percent_probability
    // TIME FUNCTIONS
    //   - get_time
    // TEST INIT
    //   - init_for_testing










    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // PERMENANTS CARDS 
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    // type_id: 1 = gnome general, 2 = gnome monster, 3 = gnome rider, 4 = gnome soldier

    struct Card has key, store {
        id: UID,
        owner_address: address,
        type: String,
        type_id: u64,
        // card_id: ID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        // ability_one: String,
    }



    public fun delete_card(card: Card) {

        let Card { id, owner_address: _, type: _, type_id: _, name: _, image_url: _ , attack: _, defense: _, health: _, cost: _ } = card;
        object::delete(id);

    }


    public fun delete_card_option(card: Option<Card>) {

       
        if (option::is_some(&card)) {
            let card_temp = option::extract(&mut card);
            delete_card(card_temp);
        };

        option::destroy_none(card);

    }   









    
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GNOME CARDS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------



    fun mint_gnome_general(ctx: &mut TxContext) : Card {
        

        Card {
            id: object::new(ctx),
            owner_address: tx_context::sender(ctx), 
            type: utf8(b"gnome general"),
            type_id: 1,
            // gnome_general_id: object::uid_to_inner(&id),
            name: utf8(b"gnome general"),
            image_url: utf8(b"QmRuTsfxHrX7gofugKgVhpD2euscH2txkHXosEpvxGUMd8"),
            attack: 10,
            defense: 2,
            health: 3,
            cost: 6,
            // ability_one: utf8(b"Rally"),
            
        }
    }


    fun transfer_gnome_general(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_general = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome general"),
            type_id: 1,
            // gnome_general_id: object::uid_to_inner(&id),
            name: utf8(b"gnome general"),
            image_url: utf8(b"QmRuTsfxHrX7gofugKgVhpD2euscH2txkHXosEpvxGUMd8"),
            attack: 10,
            defense: 2,
            health: 3,
            cost: 6,
            // ability_one: utf8(b"Rally"),
           
        };

        transfer::public_transfer(gnome_general, tx_context::sender(ctx));
    }



    fun mint_gnome_monster(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome monster"),
            type_id: 2,
            // gnome_monster_id: object::uid_to_inner(&id),
            name: utf8(b"gnome monster"),
            image_url: utf8(b"Qme7gJPZoRYJ75hBTyQUJKpiYCBacVeBEo6saJqUw99NVd"),
            attack: 8,
            defense: 8,
            health: 6,
            cost: 5,
            // ability: utf8(b"Fury Assault"),
        }
    }



    fun transfer_gnome_monster(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_monster = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome monster"),
            type_id: 2,
            // gnome_monster_id: object::uid_to_inner(&id),
            name: utf8(b"gnome monster"),
            image_url: utf8(b"Qme7gJPZoRYJ75hBTyQUJKpiYCBacVeBEo6saJqUw99NVd"),
            attack: 8,
            defense: 8,
            health: 6,
            cost: 5,
            // ability: utf8(b"Fury Assault"),
        };

        transfer::public_transfer(gnome_monster, tx_context::sender(ctx));
    }


    


    fun mint_gnome_rider(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome rider"),
            type_id: 3,
            // gnome_rider_id: object::uid_to_inner(&id),
            name: utf8(b"gnome rider"),
            image_url: utf8(b"QmYxYgTHBTs6u5yatgW8xxpD6NHVECypYUGaHRjzWr6BPG"),
            attack: 6,
            defense: 6,
            health: 4,
            cost: 4,
            // ability: utf8(b"Lightning Strike"),
        }
    }


    fun transfer_gnome_rider(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_rider = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome rider"),
            type_id: 3,
            // gnome_rider_id: object::uid_to_inner(&id),
            name: utf8(b"gnome rider"),
            image_url: utf8(b"QmYxYgTHBTs6u5yatgW8xxpD6NHVECypYUGaHRjzWr6BPG"),
            attack: 6,
            defense: 6,
            health: 4,
            cost: 4,
            // ability: utf8(b"Lightning Strike"),
        };

        transfer::public_transfer(gnome_rider, tx_context::sender(ctx));
    }


    


    fun mint_gnome_soldier(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            // gnome_soldier_id: object::uid_to_inner(&id),
            type: utf8(b"gnome soldier"),
            type_id: 4,
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"QmXkTwHYLSbuVCErb1rXsnG3dcXwdzBU9fE6WNtFjx4fLG"),
            attack: 4,
            defense: 4,
            health: 7,
            cost: 2,
            // ability: utf8(b"Shield Wall"),
        }
    }


    fun transfer_gnome_soldier(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_soldier = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome soldier"),
            type_id: 4,
            // gnome_soldier_id: object::uid_to_inner(&id),
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"QmXkTwHYLSbuVCErb1rXsnG3dcXwdzBU9fE6WNtFjx4fLG"),
            attack: 4,
            defense: 4,
            health: 7,
            cost: 2,
            // ability: utf8(b"Shield Wall"),
        };

        transfer::public_transfer(gnome_soldier, tx_context::sender(ctx));
    }


    




    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CAPYBARA CARDS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


   


    fun mint_capy_general(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy general"),
            type_id: 1,
            name: utf8(b"capy general"),
            image_url: utf8(b"QmcS4qBSBkzkFT7rVtmkFsnffAoi5bjtSA9DfEF4Y8ZRiT"),
            attack: 10,
            defense: 2,
            health: 3,
            cost: 6,
            // ability_one: utf8(b"Rally"),
            // ability_two: utf8(b"Defensive Orders"),
        }
    }


    fun transfer_capy_general(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_general = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy general"),
            type_id: 1,
            name: utf8(b"capy general"),
            image_url: utf8(b"QmcS4qBSBkzkFT7rVtmkFsnffAoi5bjtSA9DfEF4Y8ZRiT"),
            attack: 10,
            defense: 2,
            health: 3,
            cost: 6,
            // ability_one: utf8(b"Rally"),
        };

        transfer::public_transfer(capy_general, tx_context::sender(ctx));
    }


    



    fun mint_capy_monster(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy monster"),
            type_id: 2,
            name: utf8(b"capy monster"),
            image_url: utf8(b"QmULsZAotb8iDhUjWXRzW8KjqA7RedY9QdNuQL19eMpjis"),
            attack: 8,
            defense: 8,
            health: 6,
            cost: 5,
            // ability: utf8(b"Fury Assault"),
        }
    }


    fun transfer_capy_monster(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_monster = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy monster"),
            type_id: 2,
            name: utf8(b"capy monster"),
            image_url: utf8(b"QmULsZAotb8iDhUjWXRzW8KjqA7RedY9QdNuQL19eMpjis"),
            attack: 8,
            defense: 8,
            health: 6,
            cost: 5,
            // ability: utf8(b"Fury Assault"),
        };

        transfer::public_transfer(capy_monster, tx_context::sender(ctx));
    }






    fun mint_capy_rider(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy rider"),
            type_id: 3,
            name: utf8(b"capy rider"),
            image_url: utf8(b"QmZ6u3nvnArnrfTW7akBL9T2Afy2MzexfuP76EcZ8e575H"),
            attack: 6,
            defense: 6,
            health: 4,
            cost: 4,
            // ability: utf8(b"Lightning Strike"),
        }
    }



    fun transfer_capy_rider(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_rider = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy rider"),
            type_id: 3,
            name: utf8(b"capy rider"),
            image_url: utf8(b"QmZ6u3nvnArnrfTW7akBL9T2Afy2MzexfuP76EcZ8e575H"),
            attack: 6,
            defense: 6,
            health: 4,
            cost: 4,
            // ability: utf8(b"Lightning Strike"),
        };

        transfer::public_transfer(capy_rider, tx_context::sender(ctx));
    }


   


    fun mint_capy_soldier(ctx: &mut TxContext) : Card {
        let id = object::new(ctx);

        Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy soldier"),
            type_id: 4,
            name: utf8(b"capy soldier"),
            image_url: utf8(b"QmYgEa5Rv3FussydF31tndCABWE7XxnLTtscUk7yHU4GCM"),
            attack: 4,
            defense: 4,
            health: 7,
            cost: 2,
            // ability: utf8(b"Shield Wall"),
        }
    }


    fun transfer_capy_soldier(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_soldier = Card {
            id: id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"capy soldier"),
            type_id: 4,
            name: utf8(b"capy soldier"),
            image_url: utf8(b"QmYgEa5Rv3FussydF31tndCABWE7XxnLTtscUk7yHU4GCM"),
            attack: 4,
            defense: 4,
            health: 7,
            cost: 2,
            // ability: utf8(b"Shield Wall"),
        };

        transfer::public_transfer(capy_soldier, tx_context::sender(ctx));
    }







    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // PERMENANTS GETTERS 
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------




    // id: UID
    // owner_address: address
    // type: String
    // type_id: u64
    // // card_id: ID,
    // name: String
    // image_url: String
    // attack: u64
    // defense: u64
    // health: u64
    // cost: u64




    public fun owner_address(card: &Card) : address {

        let address = card.owner_address;

        address
    }



    public fun type(card: &Card) : String {

        let t = card.type;
       
        t
    }



    public fun type_id(card: &Card) : u64 {

        let t = card.type_id;
       
        t
    }



    public fun name(card: &Card) : String {

        let name = card.name;
       
        name
    }



    public fun image_url(card: &Card) : String {

        let image_url = card.image_url;
       
        image_url
    }



    public fun attack(card: &Card) : u64 {

        let attack = card.attack;
       
        attack
    }



    public fun defense(card: &Card) : u64 {

        let defense = card.defense;
       
        defense
    }



    public fun health(card: &Card) : u64 {

        let health = card.health;
       
        health
    }



    public fun cost(card: &Card) : u64 {

        let cost = card.cost;
       
        cost
    }





















    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // ONE TIME USE POWER CARDS 
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------

    
    // // DIVINE SHIELD *********************************
    // struct DivineShield has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_divine_shield( divine_shield: DivineShield, ctx: &mut TxContext) {


    //     // One character is immune to all damage and effects for one turn. (Cost: 5 CP)


    //     let DivineShield {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = divine_shield; 

    //     object::delete(id);

    // }


    // fun mint_divine_shield(ctx: &mut TxContext) : DivineShield {
    //     let id = object::new(ctx);

    //     DivineShield {
    //         id: id,
    //         name: utf8(b"divine shield"),
    //         image_url: utf8(b"QmbyA8xjAxZNfwdgGMhMDb5f2hSdQYM68kZJgGhKd6nnMz"),
    //     }
    // }


    
    // public fun delete_divine_shield(divine_shield: DivineShield) {
    //     let DivineShield { id, name: _, image_url: _ } = divine_shield;
    //     object::delete(id);
    // }

    

    // // LAST STAND *********************************
    // struct LastStand has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_last_stand( last_stand: LastStand, ctx: &mut TxContext) {


    //     // For one turn, your characters cannot be reduced below 1 health. (Cost: 5 CP)

    //     let LastStand {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = last_stand; 

    //     object::delete(id);

    // }


    // fun mint_last_stand(ctx: &mut TxContext) : LastStand {
    //     let id = object::new(ctx);

    //     LastStand {
    //         id: id,
    //         name: utf8(b"last stand"),
    //         image_url: utf8(b"Qmdq15cjatXJbuNt7rF2WM9gzb7JHbb3oexUhY1Gw4ncdy"),
    //     }
    // }


    
    // public fun delete_last_stand(last_stand: LastStand) {
    //     let LastStand { id, name: _, image_url: _ } = last_stand;
    //     object::delete(id);
    // }




    // // MASSIVE ONSLAUGHT *********************************
    // struct MassiveOnslaught has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_massive_onslaught( massive_onslaught: MassiveOnslaught, ctx: &mut TxContext) {


    //     // Your characters gain +3 attack for one turn. (Cost: 5 CP)
    //     let MassiveOnslaught {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = massive_onslaught; 

    //     object::delete(id);

    // }


    // fun mint_massive_onslaught(ctx: &mut TxContext) : MassiveOnslaught {
    //     let id = object::new(ctx);

    //     MassiveOnslaught {
    //         id: id,
    //         name: utf8(b"massive onslaught"),
    //         image_url: utf8(b"Qmf18nsatUr1Ei17aNLFAQ47uv9jW8ovCai9E9Luma1Wiv"),
    //     }
    // }


    
    // public fun delete_massive_onslaught(massive_onslaught: MassiveOnslaught) {
    //     let MassiveOnslaught { id, name: _, image_url: _ } = massive_onslaught;
    //     object::delete(id);
    // }







    // // ----------------------------------------------
    // // SPECIAL ACTIONS
    // // ----------------------------------------------

    // // BATTLE CRY **************************************
    // struct BattleCry has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_battle_cry( battle_cry: BattleCry, ctx: &mut TxContext) {


    //     // All your characters gain +1 attack for the turn. (Cost: 3 CP)

    //     let BattleCry {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = battle_cry; 

    //     object::delete(id);

    // }


    // fun mint_battle_cry(ctx: &mut TxContext) : BattleCry {
    //     let id = object::new(ctx);

    //     BattleCry {
    //         id: id,
    //         name: utf8(b"battle cry"),
    //         image_url: utf8(b"QmW3GBdKzxeHmuvym4pPNg6VHJuHsTFDEscoB97LXxon5G"),
    //     }
    // }


    
    // public fun delete_battle_cry(battle_cry: BattleCry) {
    //     let BattleCry { id, name: _, image_url: _ } = battle_cry;
    //     object::delete(id);
    // }




    // // DECISIVE STRIKE *********************************
    // struct DecisiveStrike has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_decisive_strike( decisive_strike: DecisiveStrike, ctx: &mut TxContext) {


    //     // Deal 3 damage directly to an enemy character; this damage bypasses normal defense calculations. (Cost: 4 CP)

    //     let DecisiveStrike {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = decisive_strike; 

    //     object::delete(id);

    // }


    // fun mint_decisive_strike(ctx: &mut TxContext) : DecisiveStrike {
    //     let id = object::new(ctx);

    //     DecisiveStrike {
    //         id: id,
    //         name: utf8(b"decisive strike"),
    //         image_url: utf8(b"QmZ9CiMeEEJRCo1K31CnQw1ELqq76Yh3r72eqHi7TkDKGw"),
    //     }
    // }


    
    // public fun delete_decisive_strike(decisive_strike: DecisiveStrike) {
    //     let DecisiveStrike { id, name: _, image_url: _ } = decisive_strike;
    //     object::delete(id);
    // }




    // // SHIELD BASH *************************************
    // struct ShieldBash has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_shield_bash( shield_bash: ShieldBash, ctx: &mut TxContext) {


    //     // If your character successfully defends against an attack, deal 2 damage to the attacker. (Cost: 2 CP)
    //     let ShieldBash {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = shield_bash; 

    //     object::delete(id);

    // }


    // fun mint_shield_bash(ctx: &mut TxContext) : ShieldBash {
    //     let id = object::new(ctx);

    //     ShieldBash {
    //         id: id,
    //         name: utf8(b"shield bash"),
    //         image_url: utf8(b"QmWfHkQL2hkTDmWAhe7DGmbU88QnFRw2ChzFKm2n2hHxt5"),
    //     }
    // }


    
    // public fun delete_shield_bash(shield_bash: ShieldBash) {
    //     let ShieldBash { id, name: _, image_url: _ } = shield_bash;
    //     object::delete(id);
    // }










    // // ----------------------------------------------
    // // STAT MODIFIERS
    // // ----------------------------------------------
    // // BOOST ATTACK **************************************
    // struct BoostAttack has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_boost_attack( boost_attack: BoostAttack, ctx: &mut TxContext) {


    //     // Temporarily increases a character's attack by +2 for one turn. (Cost: 2 CP)
    //     let BoostAttack {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = boost_attack; 

    //     object::delete(id);

    // }


    // fun mint_boost_attack(ctx: &mut TxContext) : BoostAttack {
    //     let id = object::new(ctx);

    //     BoostAttack {
    //         id: id,
    //         name: utf8(b"boost attack"),
    //         image_url: utf8(b"QmZiYuc9GCj7qaPMqJRb5NzuXwAF7NRngqxBVTSJtLAQZb"),
    //     }
    // }


    
    // public fun delete_boost_attack(boost_attack: BoostAttack) {
    //     let BoostAttack { id, name: _, image_url: _ } = boost_attack;
    //     object::delete(id);
    // }




    // // FORTIFY DEFENSE *********************************
    // struct FortifyDefense has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_fortify_defense( fortify_defense: FortifyDefense, ctx: &mut TxContext) {


    //     // Increases a character's defense by +2 until your next turn. (Cost: 2 CP)
    //     let FortifyDefense {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = fortify_defense; 

    //     object::delete(id);

    // }


    // fun mint_fortify_defense(ctx: &mut TxContext) : FortifyDefense {
    //     let id = object::new(ctx);

    //     FortifyDefense {
    //         id: id,
    //         name: utf8(b"fortify defense"),
    //         image_url: utf8(b"QmdJpA2xaj5WEbAWitW56z76LQvWJvYAVFgj7ctS2E5Pwh"),
    //     }
    // }


    
    // public fun delete_fortify_defense(fortify_defense: FortifyDefense) {
    //     let FortifyDefense { id, name: _, image_url: _ } = fortify_defense;
    //     object::delete(id);
    // }




    // // VITALITY SURGE ********************************
    // struct VitalitySurge has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_vitality_surge( vitality_surge: VitalitySurge, ctx: &mut TxContext) {


    //     // Immediately restore 3 health to a character. (Cost: 3 CP)
    //     let VitalitySurge {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = vitality_surge; 

    //     object::delete(id);

    // }


    // fun mint_vitality_surge(ctx: &mut TxContext) : VitalitySurge {
    //     let id = object::new(ctx);

    //     VitalitySurge {
    //         id: id,
    //         name: utf8(b"vitality surge"),
    //         image_url: utf8(b"QmSBKeHcxjkzNLAM1z8sohSwzrhN2ZjXwwMuUdhBKWmFP5"),
    //     }
    // }


    
    // public fun delete_vitality_surge(vitality_surge: VitalitySurge) {
    //     let VitalitySurge { id, name: _, image_url: _ } = vitality_surge;
    //     object::delete(id);
    // }










    // // ----------------------------------------------
    // // TACTICAL MOVES
    // // ----------------------------------------------

    // // AMBUSH **************************************
    // struct Ambush has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_ambush( ambush: Ambush, ctx: &mut TxContext) {


    //     // Play this card when an opponent declares an attack; your character gains +3 to defense for that combat. (Cost: 3 CP)

    //     let Ambush {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = ambush; 

    //     object::delete(id);

    // }


    // fun mint_ambush(ctx: &mut TxContext) : Ambush {
    //     let id = object::new(ctx);

    //     Ambush {
    //         id: id,
    //         name: utf8(b"ambush"),
    //         image_url: utf8(b"QmP15Ja7u7tE4VUrNCrmTnfvpq3SffoHTNK9SvRhSH6k2e"),
    //     }
    // }


    
    // public fun delete_ambush(ambush: Ambush) {
    //     let Ambush { id, name: _, image_url: _ } = ambush;
    //     object::delete(id);
    // }




    // // QUICK RETREAT *********************************
    // struct QuickRetreat has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_quick_retreat( quick_retreat: QuickRetreat, ctx: &mut TxContext) {


    //     // Move one of your characters to a reserve position, making it untargetable until the next turn. (Cost: 2 CP)
    //     let QuickRetreat {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = quick_retreat; 

    //     object::delete(id);

    // }


    // fun mint_quick_retreat(ctx: &mut TxContext) : QuickRetreat {
    //     let id = object::new(ctx);

    //     QuickRetreat {
    //         id: id,
    //         name: utf8(b"quick retreat"),
    //         image_url: utf8(b"QmcDZEL2kv1CuiUs19i23yHoiaGFyXzoqJ8VBZaNa51qoG"),
    //     }
    // }


    
    // public fun delete_quick_retreat(quick_retreat: QuickRetreat) {
    //     let QuickRetreat { id, name: _, image_url: _ } = quick_retreat;
    //     object::delete(id);
    // }




    // // REINFORCEMENTS *********************************
    // struct Reinforcements has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_reinforcements( reinforcements: Reinforcements, ctx: &mut TxContext) {


    //     // Draw two cards from your deck. (Cost: 2 CP)
    //     let Reinforcements {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = reinforcements; 

    //     object::delete(id);

    // }


    // fun mint_reinforcements(ctx: &mut TxContext) : Reinforcements {
    //     let id = object::new(ctx);

    //     Reinforcements {
    //         id: id,
    //         name: utf8(b"reinforcements"),
    //         image_url: utf8(b"QmQiyCzdZX2U134byPS8RWQVZTpQVHyzpB2Y9EpY3zp6gP"),
    //     }
    // }


    
    // public fun delete_reinforcements(reinforcements: Reinforcements) {
    //     let Reinforcements { id, name: _, image_url: _ } = reinforcements;
    //     object::delete(id);
    // }







    // // ----------------------------------------------
    // // STRATEGIC EFFECTS
    // // ----------------------------------------------

    // // PEACE TREATY ***********************************
    // struct PeaceTreaty has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_peace_treaty( peace_treaty: PeaceTreaty, ctx: &mut TxContext) {


    //     // Neither player can attack for the next turn. (Cost: 2 CP)
    //     let PeaceTreaty {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = peace_treaty; 

    //     object::delete(id);

    // }


    // fun mint_peace_treaty(ctx: &mut TxContext) : PeaceTreaty {
    //     let id = object::new(ctx);

    //     PeaceTreaty {
    //         id: id,
    //         name: utf8(b"peace treaty"),
    //         image_url: utf8(b"QmdmVfDUNuAutLCzEb2qML7fHCpJKvn58qcGTgNLcdU9FX"),
    //     }
    // }


    
    // public fun delete_peace_treaty(peace_treaty: PeaceTreaty) {
    //     let PeaceTreaty { id, name: _, image_url: _ } = peace_treaty;
    //     object::delete(id);
    // }




    // // SABOTAGE **************************************
    // struct Sabotage has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_sabotage( sabotage: Sabotage, ctx: &mut TxContext) {


    //     // Target opponent generates 2 less CP on their next turn. (Cost: 3 CP)
    //     let Sabotage {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = sabotage; 

    //     object::delete(id);

    // }


    // fun mint_sabotage(ctx: &mut TxContext) : Sabotage {
    //     let id = object::new(ctx);

    //     Sabotage {
    //         id: id,
    //         name: utf8(b"sabotage"),
    //         image_url: utf8(b"QmUpTEBV4wX5MEcRnCv6BL6oYYrcRZ4WPK2aq6QCkntU43"),
    //     }
    // }


    
    // public fun delete_sabotage(sabotage: Sabotage) {
    //     let Sabotage { id, name: _, image_url: _ } = sabotage;
    //     object::delete(id);
    // }




    // // WAR DRUMS *************************************
    // struct WarDrums has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_war_drums( war_drums: WarDrums, ctx: &mut TxContext) {


    //     // Increase the CP generation by 1 for the next two turns. (Cost: 4 CP)
    //     let WarDrums {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = war_drums; 

    //     object::delete(id);

    // }


    // fun mint_war_drums(ctx: &mut TxContext) : WarDrums {
    //     let id = object::new(ctx);

    //     WarDrums {
    //         id: id,
    //         name: utf8(b"war drums"),
    //         image_url: utf8(b"QmYQvueWZj2iTB7TE2ainaEsjyijApNusJatZUnWtcHepX"),
    //     }
    // }


    
    // public fun delete_war_drums(war_drums: WarDrums) {
    //     let WarDrums { id, name: _, image_url: _ } = war_drums;
    //     object::delete(id);
    // }









    // // ----------------------------------------------
    // // UTILITY CARDS
    // // ----------------------------------------------

    // // ESPIONAGE **************************************
    // struct Espionage has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_espionage( espionage: Espionage, ctx: &mut TxContext) {


    //     // Look at an opponent's hand, select one card they must discard. (Cost: 4 CP)
    //     let Espionage {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = espionage; 

    //     object::delete(id);

    // }


    // fun mint_espionage(ctx: &mut TxContext) : Espionage {
    //     let id = object::new(ctx);

    //     Espionage {
    //         id: id,
    //         name: utf8(b"espionage"),
    //         image_url: utf8(b"QmUqrhZu3GFB3XSR9jVUNdnZb3rENKR1ZuEGXeUMUjD683"),
    //     }
    // }


    
    // public fun delete_espionage(espionage: Espionage) {
    //     let Espionage { id, name: _, image_url: _ } = espionage;
    //     object::delete(id);
    // }




    // // REGROUP ***************************************
    // struct Regroup has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_regroup( regroup: Regroup, ctx: &mut TxContext) {


    //     // Shuffle up to three cards from your discard pile back into your deck. (Cost: 3 CP)
    //     let Regroup {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = regroup; 

    //     object::delete(id);

    // }


    // fun mint_regroup(ctx: &mut TxContext) : Regroup {
    //     let id = object::new(ctx);

    //     Regroup {
    //         id: id,
    //         name: utf8(b"regroup"),
    //         image_url: utf8(b"QmS2NR8uVd3gHMPXj2F7Nj4sgQCPa4WnpBiqaugYVsYwdz"),
    //     }
    // }


    
    // public fun delete_regroup(regroup: Regroup) {
    //     let Regroup { id, name: _, image_url: _ } = regroup;
    //     object::delete(id);
    // }




    // // SCOUT *****************************************
    // struct Scout has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_scout( scout: Scout, ctx: &mut TxContext) {


    //     // Shuffle up to three cards from your discard pile back into your deck. (Cost: 3 CP)
    //     let Scout {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = scout; 

    //     object::delete(id);

    // }


    // fun mint_scout(ctx: &mut TxContext) : Scout {
    //     let id = object::new(ctx);

    //     Scout {
    //         id: id,
    //         name: utf8(b"scout"),
    //         image_url: utf8(b"QmQX6vo2GviSJp3wXzLP56SLPL8vsMmqSN7sPDpJDTVYQT"),
    //     }
    // }


    
    // public fun delete_scout(scout: Scout) {
    //     let Scout { id, name: _, image_url: _ } = scout;
    //     object::delete(id);
    // }






    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // INIT
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------

    




    struct CARD_DECK has drop {}


    fun init(otw: CARD_DECK, ctx: &mut TxContext) {




        // gnome general
        let gnome_general_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_general_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // gnome monster
        let gnome_monster_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_monster_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // gnome rider
        let gnome_rider_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_rider_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // gnome rider
        let gnome_soldier_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let gnome_soldier_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];



        // capy characters
        // capy general
        let capy_general_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_general_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // capy monster
        let capy_monster_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_monster_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // capy rider
        let capy_rider_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_rider_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];

        // capy soldier
        let capy_soldier_keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let capy_soldier_values = vector[
            utf8(b"{name}"),
            utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
            utf8(b"ipfs://{image_url}"),
            utf8(b"capy vs. gnome"),
            utf8(b"https://capy-vs-gnome.xyz"),
            utf8(b"unk"),
        ];



        // divine shield
        // let divine_shield_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let divine_shield_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];


        // // last stand
        // let last_stand_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let last_stand_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // massive onslaught
        // let massive_onslaught_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let massive_onslaught_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // battle cry
        // let battle_cry_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let battle_cry_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // decisive strike
        // let decisive_strike_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let decisive_strike_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // shield bash
        // let shield_bash_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let shield_bash_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // boost attack
        // let boost_attack_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let boost_attack_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // fortify defense
        // let fortify_defense_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let fortify_defense_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // vitality surge
        // let vitality_surge_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let vitality_surge_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // ambush
        // let ambush_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let ambush_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // quick retreat
        // let quick_retreat_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let quick_retreat_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // reinforcements
        // let reinforcements_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let reinforcements_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // peace treaty
        // let peace_treaty_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let peace_treaty_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // sabotage
        // let sabotage_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let sabotage_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // war drums
        // let war_drums_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let war_drums_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // espionage
        // let espionage_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let espionage_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // regroup
        // let regroup_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let regroup_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // scout
        // let scout_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let scout_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];




        let publisher = package::claim(otw, ctx);


        // add gnomes to display
        // add gnome general
        let display_gnome_general = display::new_with_fields<Card>(
            &publisher, gnome_general_keys, gnome_general_values, ctx
        );

        display::update_version(&mut display_gnome_general);


        // add gnome monster
        let display_gnome_monster = display::new_with_fields<Card>(
            &publisher, gnome_monster_keys, gnome_monster_values, ctx
        );

        display::update_version(&mut display_gnome_monster);


        // add gnome rider
        let display_gnome_rider = display::new_with_fields<Card>(
            &publisher, gnome_rider_keys, gnome_rider_values, ctx
        );

        display::update_version(&mut display_gnome_rider);


        // add gnome soldier
        let display_gnome_soldier = display::new_with_fields<Card>(
            &publisher, gnome_soldier_keys, gnome_soldier_values, ctx
        );

        display::update_version(&mut display_gnome_soldier);




        // add capybaras to display
        // add capy general
        let display_capy_general = display::new_with_fields<Card>(
            &publisher, capy_general_keys, capy_general_values, ctx
        );

        display::update_version(&mut display_capy_general);


        // add capy monster
        let display_capy_monster = display::new_with_fields<Card>(
            &publisher, capy_monster_keys, capy_monster_values, ctx
        );

        display::update_version(&mut display_capy_monster);


        // add capy rider
        let display_capy_rider = display::new_with_fields<Card>(
            &publisher, capy_rider_keys, capy_rider_values, ctx
        );

        display::update_version(&mut display_capy_rider);


        // add capy soldier
        let display_capy_soldier = display::new_with_fields<Card>(
            &publisher, capy_soldier_keys, capy_soldier_values, ctx
        );

        display::update_version(&mut display_capy_soldier);




        // // divine shield
        // let display_divine_shield = display::new_with_fields<DivineShield>(
        //     &publisher, divine_shield_keys, divine_shield_values, ctx
        // );

        // display::update_version(&mut display_divine_shield);


        // // last stand
        // let display_last_stand = display::new_with_fields<LastStand>(
        //     &publisher, last_stand_keys, last_stand_values, ctx
        // );

        // display::update_version(&mut display_last_stand);

        // // massive onslaught
        // let display_massive_onslaught = display::new_with_fields<MassiveOnslaught>(
        //     &publisher, massive_onslaught_keys, massive_onslaught_values, ctx
        // );

        // display::update_version(&mut display_massive_onslaught);
        
        // // battle cry
        // let display_battle_cry = display::new_with_fields<BattleCry>(
        //     &publisher, battle_cry_keys, battle_cry_values, ctx
        // );

        // display::update_version(&mut display_battle_cry);

        // // decisive strike
        // let display_decisive_strike = display::new_with_fields<DecisiveStrike>(
        //     &publisher, decisive_strike_keys, decisive_strike_values, ctx
        // );

        // display::update_version(&mut display_decisive_strike);

        // // shield bash
        // let display_shield_bash = display::new_with_fields<ShieldBash>(
        //     &publisher, shield_bash_keys, shield_bash_values, ctx
        // );

        // display::update_version(&mut display_shield_bash);

        // // boost attack
        // let display_boost_attack = display::new_with_fields<BoostAttack>(
        //     &publisher, boost_attack_keys, boost_attack_values, ctx
        // );

        // display::update_version(&mut display_boost_attack);

        // // fortify defense
        // let display_fortify_defense = display::new_with_fields<FortifyDefense>(
        //     &publisher, fortify_defense_keys, fortify_defense_values, ctx
        // );

        // display::update_version(&mut display_fortify_defense);

        // // vitality surge
        // let display_vitality_surge = display::new_with_fields<VitalitySurge>(
        //     &publisher, vitality_surge_keys, vitality_surge_values, ctx
        // );

        // display::update_version(&mut display_vitality_surge);

        // // ambush
        // let display_ambush= display::new_with_fields<Ambush>(
        //     &publisher, ambush_keys, ambush_values, ctx
        // );

        // display::update_version(&mut display_ambush);

        // // quick retreat
        // let display_quick_retreat= display::new_with_fields<QuickRetreat>(
        //     &publisher, quick_retreat_keys, quick_retreat_values, ctx
        // );

        // display::update_version(&mut display_quick_retreat);

        // // reinforcements
        // let display_reinforcements = display::new_with_fields<Reinforcements>(
        //     &publisher, reinforcements_keys, reinforcements_values, ctx
        // );

        // display::update_version(&mut display_reinforcements);

        // // peace treaty
        // let display_peace_treaty = display::new_with_fields<PeaceTreaty>(
        //     &publisher, peace_treaty_keys, peace_treaty_values, ctx
        // );

        // display::update_version(&mut display_peace_treaty);

        // // sabotage
        // let display_sabotage = display::new_with_fields<Sabotage>(
        //     &publisher, sabotage_keys, sabotage_values, ctx
        // );

        // display::update_version(&mut display_sabotage);
        
        // // war drums
        // let display_war_drums = display::new_with_fields<WarDrums>(
        //     &publisher, war_drums_keys, war_drums_values, ctx
        // );

        // display::update_version(&mut display_war_drums);

        // // espionage
        // let display_espionage = display::new_with_fields<Espionage>(
        //     &publisher, espionage_keys, espionage_values, ctx
        // );

        // display::update_version(&mut display_espionage);

        // // regroup
        // let display_regroup = display::new_with_fields<Regroup>(
        //     &publisher, regroup_keys, regroup_values, ctx
        // );

        // display::update_version(&mut display_regroup);

        // // scout
        // let display_scout= display::new_with_fields<Scout>(
        //     &publisher, scout_keys, scout_values, ctx
        // );

        // display::update_version(&mut display_scout);



        // transfer publisher
        transfer::public_transfer(publisher, tx_context::sender(ctx));
        
        // transfer character displays
       
        // gnomes
        transfer::public_transfer(display_gnome_general, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_monster, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_rider, tx_context::sender(ctx));
        transfer::public_transfer(display_gnome_soldier, tx_context::sender(ctx));
        
        // capybaras
        transfer::public_transfer(display_capy_general, tx_context::sender(ctx));
        transfer::public_transfer(display_capy_monster, tx_context::sender(ctx));
        transfer::public_transfer(display_capy_rider, tx_context::sender(ctx));
        transfer::public_transfer(display_capy_soldier, tx_context::sender(ctx));
        
        // divine shield
        // transfer::public_transfer(display_divine_shield, tx_context::sender(ctx));
        
        // // last stand
        // transfer::public_transfer(display_last_stand, tx_context::sender(ctx));
        
        // // massive onslaught
        // transfer::public_transfer(display_massive_onslaught, tx_context::sender(ctx));

        // // battle cry
        // transfer::public_transfer(display_battle_cry, tx_context::sender(ctx));

        // // decisive strike
        // transfer::public_transfer(display_decisive_strike, tx_context::sender(ctx));

        // // shield bash
        // transfer::public_transfer(display_shield_bash, tx_context::sender(ctx));

        // // boost attack
        // transfer::public_transfer(display_boost_attack, tx_context::sender(ctx));

        // // fortify defense
        // transfer::public_transfer(display_fortify_defense, tx_context::sender(ctx));

        // // vitality surge
        // transfer::public_transfer(display_vitality_surge, tx_context::sender(ctx));

        // // ambush
        // transfer::public_transfer(display_ambush, tx_context::sender(ctx));

        // // quick retreat
        // transfer::public_transfer(display_quick_retreat, tx_context::sender(ctx));

        // // reinforcements
        // transfer::public_transfer(display_reinforcements, tx_context::sender(ctx));

        // // peace treaty
        // transfer::public_transfer(display_peace_treaty, tx_context::sender(ctx));

        // // sabotage
        // transfer::public_transfer(display_sabotage, tx_context::sender(ctx));

        // // war drums
        // transfer::public_transfer(display_war_drums, tx_context::sender(ctx));

        // // espionage
        // transfer::public_transfer(display_espionage, tx_context::sender(ctx));

        // // regroup
        // transfer::public_transfer(display_regroup, tx_context::sender(ctx));

        // // scout
        // transfer::public_transfer(display_scout, tx_context::sender(ctx));


    }












    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // MINT DECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------





    // MINT DECKS
    // public fun mint_main_deck_cards(ctx: &mut TxContext) : (DivineShield, DivineShield, LastStand, LastStand, MassiveOnslaught, MassiveOnslaught, BattleCry, BattleCry, DecisiveStrike, DecisiveStrike, ShieldBash, ShieldBash, BoostAttack, BoostAttack, FortifyDefense, FortifyDefense, VitalitySurge, VitalitySurge, Ambush, Ambush, QuickRetreat, QuickRetreat, Reinforcements, Reinforcements, PeaceTreaty, PeaceTreaty, Sabotage, Sabotage, WarDrums, WarDrums, Espionage, Espionage, Regroup, Regroup, Scout, Scout) {  

    //     let divine_shield = mint_divine_shield(ctx);
    //     let divine_shield_two = mint_divine_shield(ctx);

    //     let last_stand = mint_last_stand(ctx);
    //     let last_stand_two = mint_last_stand(ctx);

    //     let massive_onslaught = mint_massive_onslaught(ctx);
    //     let massive_onslaught_two = mint_massive_onslaught(ctx);

    //     let battle_cry = mint_battle_cry(ctx);
    //     let battle_cry_two = mint_battle_cry(ctx);

    //     let decisive_strike = mint_decisive_strike(ctx);
    //     let decisive_strike_two = mint_decisive_strike(ctx);

    //     let shield_bash = mint_shield_bash(ctx);
    //     let shield_bash_two = mint_shield_bash(ctx);

    //     let boost_attack = mint_boost_attack(ctx);
    //     let boost_attack_two = mint_boost_attack(ctx);

    //     let fortify_defense = mint_fortify_defense(ctx);
    //     let fortify_defense_two = mint_fortify_defense(ctx);

    //     let vitality_surge = mint_vitality_surge(ctx);
    //     let vitality_surge_two = mint_vitality_surge(ctx);

    //     let ambush = mint_ambush(ctx);
    //     let ambush_two = mint_ambush(ctx);

    //     let quick_retreat = mint_quick_retreat(ctx);
    //     let quick_retreat_two = mint_quick_retreat(ctx);

    //     let reinforcements = mint_reinforcements(ctx);
    //     let reinforcements_two = mint_reinforcements(ctx);

    //     let peace_treaty = mint_peace_treaty(ctx);
    //     let peace_treaty_two = mint_peace_treaty(ctx);

    //     let sabotage = mint_sabotage(ctx);
    //     let sabotage_two = mint_sabotage(ctx);

    //     let war_drums = mint_war_drums(ctx);
    //     let war_drums_two = mint_war_drums(ctx);

    //     let espionage = mint_espionage(ctx);
    //     let espionage_two = mint_espionage(ctx);

    //     let regroup = mint_regroup(ctx);
    //     let regroup_two = mint_regroup(ctx);

    //     let scout = mint_scout(ctx);
    //     let scout_two = mint_scout(ctx);


    //     (divine_shield, divine_shield_two, last_stand, last_stand_two, massive_onslaught, massive_onslaught_two, battle_cry, battle_cry_two, decisive_strike, decisive_strike_two, shield_bash, shield_bash_two, boost_attack, boost_attack_two, fortify_defense, fortify_defense_two, vitality_surge, vitality_surge_two, ambush, ambush_two, quick_retreat, quick_retreat_two, reinforcements, reinforcements_two, peace_treaty, peace_treaty_two, sabotage, sabotage_two, war_drums, war_drums_two, espionage, espionage_two, regroup, regroup_two, scout, scout_two)

    
        
    // } 







     // GNOME DECK

    public fun mint_gnome_cards(ctx: &mut TxContext) : (Card, Card, Card, Card) {

        
        
        let gnome_general = mint_gnome_general(ctx);
        let gnome_monster = mint_gnome_monster(ctx);
        let gnome_rider = mint_gnome_rider(ctx);
        let gnome_soldier = mint_gnome_soldier(ctx);
      


        (gnome_general, gnome_monster, gnome_rider, gnome_soldier)      


    } 
    



    public fun transfer_gnome_cards(ctx: &mut TxContext) {
            
            let gnome_general = mint_gnome_general(ctx);
            let gnome_monster = mint_gnome_monster(ctx);
            let gnome_rider = mint_gnome_rider(ctx);
            let gnome_soldier = mint_gnome_soldier(ctx);
    
            transfer::public_transfer(gnome_general, tx_context::sender(ctx));
            transfer::public_transfer(gnome_monster, tx_context::sender(ctx));
            transfer::public_transfer(gnome_rider, tx_context::sender(ctx));
            transfer::public_transfer(gnome_soldier, tx_context::sender(ctx));

    }







    public fun gnome_deck(ctx: &mut TxContext) : (Card, Card, Card, Card) {


        let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_cards(ctx);
        // let (divine_shield, divine_shield_two, 
        // last_stand, last_stand_two, 
        // massive_onslaught, massive_onslaught_two, 
        // battle_cry, battle_cry_two, 
        // decisive_strike, decisive_strike_two, 
        // shield_bash, shield_bash_two, 
        // boost_attack, boost_attack_two, 
        // fortify_defense, fortify_defense_two, 
        // vitality_surge, vitality_surge_two, 
        // ambush, ambush_two, 
        // quick_retreat, quick_retreat_two, 
        // reinforcements, reinforcements_two, 
        // peace_treaty, peace_treaty_two, 
        // sabotage, sabotage_two, 
        // war_drums, war_drums_two, 
        // espionage, espionage_two, 
        // regroup, regroup_two, 
        // scout, scout_two)
        // = mint_main_deck_cards(ctx);



        
        (gnome_general, gnome_monster, gnome_rider, gnome_soldier)
        //  divine_shield, divine_shield_two, 
        //  last_stand, last_stand_two, 
        //  massive_onslaught, massive_onslaught_two, 
        //  battle_cry, battle_cry_two, 
        //  decisive_strike, decisive_strike_two, 
        //  shield_bash, shield_bash_two, 
        //  boost_attack, boost_attack_two, 
        //  fortify_defense, fortify_defense_two, 
        //  vitality_surge, vitality_surge_two, 
        //  ambush, ambush_two, 
        //  quick_retreat, quick_retreat_two, 
        //  reinforcements, reinforcements_two, 
        //  peace_treaty, peace_treaty_two, 
        //  sabotage, sabotage_two, 
        //  war_drums, war_drums_two, 
        //  espionage, espionage_two, 
        //  regroup, regroup_two, 
        //  scout, scout_two)


    }



    public fun delete_all_gnome_cards(gnome_general: Card, gnome_monster: Card, gnome_rider: Card, gnome_soldier: Card, ctx: &mut TxContext) {
        
        delete_card(gnome_general);
        delete_card(gnome_monster);
        delete_card(gnome_rider);
        delete_card(gnome_soldier);

        // delete_divine_shield(divine_shield);
        // delete_divine_shield(divine_shield_two);
        // delete_last_stand(last_stand);
        // delete_last_stand(last_stand_two);
        // delete_massive_onslaught(massive_onslaught);
        // delete_massive_onslaught(massive_onslaught_two);
        // delete_battle_cry(battle_cry);
        // delete_battle_cry(battle_cry_two);
        // delete_decisive_strike(decisive_strike);
        // delete_decisive_strike(decisive_strike_two);
        // delete_shield_bash(shield_bash);
        // delete_shield_bash(shield_bash_two);
        // delete_boost_attack(boost_attack);
        // delete_boost_attack(boost_attack_two);
        // delete_fortify_defense(fortify_defense);
        // delete_fortify_defense(fortify_defense_two);
        // delete_vitality_surge(vitality_surge);
        // delete_vitality_surge(vitality_surge_two);
        // delete_ambush(ambush);
        // delete_ambush(ambush_two);
        // delete_quick_retreat(quick_retreat);
        // delete_quick_retreat(quick_retreat_two);
        // delete_reinforcements(reinforcements);
        // delete_reinforcements(reinforcements_two);
        // delete_peace_treaty(peace_treaty);
        // delete_peace_treaty(peace_treaty_two);
        // delete_sabotage(sabotage);
        // delete_sabotage(sabotage_two);
        // delete_war_drums(war_drums);
        // delete_war_drums(war_drums_two);
        // delete_espionage(espionage);
        // delete_espionage(espionage_two);
        // delete_regroup(regroup);
        // delete_regroup(regroup_two);
        // delete_scout(scout);
        // delete_scout(scout_two);

    }






    
    // CAPY DECK
    // public fun mint_capy_cards(ctx: &mut TxContext) : CapyDeck {
 
        
    // }


    public fun transfer_capy_cards(ctx: &mut TxContext) {

        let capy_general = mint_capy_general(ctx);
        let capy_monster = mint_capy_monster(ctx);
        let capy_rider = mint_capy_rider(ctx);
        let capy_soldier = mint_capy_soldier(ctx);

        transfer::public_transfer(capy_general, tx_context::sender(ctx));
        transfer::public_transfer(capy_monster, tx_context::sender(ctx));
        transfer::public_transfer(capy_rider, tx_context::sender(ctx));
        transfer::public_transfer(capy_soldier, tx_context::sender(ctx));

    }




     public fun mint_capy_cards(ctx: &mut TxContext) : (Card, Card, Card, Card) {

        
        
        let capy_general = mint_capy_general(ctx);
        let capy_monster = mint_capy_monster(ctx);
        let capy_rider = mint_capy_rider(ctx);
        let capy_soldier = mint_capy_soldier(ctx);
      


        (capy_general, capy_monster, capy_rider, capy_soldier)      


    } 







    public fun capy_deck(ctx: &mut TxContext) : (Card, Card, Card, Card) {


        let (capy_general, capy_monster, capy_rider, capy_soldier) = mint_capy_cards(ctx);
        



        
        (capy_general, capy_monster, capy_rider, capy_soldier)
        


    }



    public fun delete_all_capy_cards(capy_general: Card, capy_monster: Card, capy_rider: Card, capy_soldier: Card, ctx: &mut TxContext) {
        
        delete_card(capy_general);
        delete_card(capy_monster);
        delete_card(capy_rider);
        delete_card(capy_soldier);

        

    }


















    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CONFIRM DECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    struct ConfirmedDeck has key, store {
        id: UID,
        
        general_id: ID,
        monster_id: ID,
        rider_id: ID,
        soldier_id: ID,

        
    }




    // to confirm the playesrs are using an accurate deck and correct cards during gameplay
    public fun confirm_deck( general: Card, monster: Card, rider: Card, soldier: Card, ctx: &mut TxContext) {


        // instantiate first to avoid error then check
        // create as shared object with object ids to later use to check and verify 
        let confirmed_deck = ConfirmedDeck {
            id: object::new(ctx),
            general_id: object::id(&general),
            monster_id: object::id(&monster),
            rider_id: object::id(&rider),
            soldier_id: object::id(&soldier),
        };



        // assert that the gnome cards attack is correct
        if(general.attack == 10){
            confirmed_deck.general_id = object::id(&general)
        } else {
            abort(1)
        };
        
        if(monster.attack == 8){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.attack == 6){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.attack == 4){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };

        // assert that the gnome cards defense is correct
        if(general.defense == 2){
            confirmed_deck.general_id = object::id(&general)
        }else {
            abort(1)
        };
        if(monster.defense  == 8){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.defense  == 6){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.defense  == 4){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };

        // assert that the gnome cards health is correct
        if(general.health == 3){
            confirmed_deck.general_id = object::id(&general)
        } else {
            abort(1)
        };
        if(monster.health == 6){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.health == 4){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.health == 7){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };


        // assert that the gnome cards monsti cost is correct
        if(general.cost == 6){
            confirmed_deck.general_id = object::id(&general)
        } else {
            abort(1)
        };
        if(monster.cost == 5){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.cost == 4){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.cost == 2){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };



        transfer::public_share_object(confirmed_deck);
        transfer::public_transfer(general, tx_context::sender(ctx));
        transfer::public_transfer(monster, tx_context::sender(ctx));
        transfer::public_transfer(rider, tx_context::sender(ctx));
        transfer::public_transfer(soldier, tx_context::sender(ctx));



    }





    #[test_only]
    public fun confirm_deck_for_testing( general: Card, monster: Card, rider: Card, soldier: Card, ctx: &mut TxContext) : (Card, Card, Card, Card) {


        // instantiate first to avoid error then check
        // create as shared object with object ids to later use to check and verify 
        let confirmed_deck = ConfirmedDeck {
            id: object::new(ctx),
            general_id: object::id(&general),
            monster_id: object::id(&monster),
            rider_id: object::id(&rider),
            soldier_id: object::id(&soldier),
        };



        // assert that the gnome cards attack is correct
        if(general.attack == 10){
            confirmed_deck.general_id = object::id(&general)
        } else {
            abort(1)
        };
        
        if(monster.attack == 8){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.attack == 6){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.attack == 4){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };

        // assert that the gnome cards defense is correct
        if(general.defense == 2){
            confirmed_deck.general_id = object::id(&general)
        }else {
            abort(1)
        };
        if(monster.defense  == 8){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.defense  == 6){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.defense  == 4){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };

        // assert that the gnome cards health is correct
        if(general.health == 3){
            confirmed_deck.general_id = object::id(&general)
        } else {
            abort(1)
        };
        if(monster.health == 6){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.health == 4){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.health == 7){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };


        // assert that the gnome cards monsti cost is correct
        if(general.cost == 6){
            confirmed_deck.general_id = object::id(&general)
        } else {
            abort(1)
        };
        if(monster.cost == 5){
            confirmed_deck.monster_id = object::id(&monster)
        } else {
            abort(1)
        };
        if(rider.cost == 4){
            confirmed_deck.rider_id = object::id(&rider)
        } else {
            abort(1)
        };
        if(soldier.cost == 2){
            confirmed_deck.soldier_id = object::id(&soldier)
        } else {
            abort(1)
        };



        transfer::public_share_object(confirmed_deck);


        
        (general, monster, rider, soldier)



    }



    







    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------



    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GAME SETUP
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    // GAME_SETUP
    // Game
    // TurnKey
    // start_game
    // turn_trial
    // first_turn
    // HashedSelection
    // HashedSelectionProved
    // HashedSelectionMade
    // HashedSelectionProvedMade
    // hashed_selection
    // prove_hashed_selection



    struct GAME_SETUP has drop {}



    struct Game has key, store {

        id: UID,
        player_one_address: address,
        player_two_address: address,
        coin_flip_guess: u8,
        coin_flip_count: u8,
        coin_flip_result: u8,
        even_turns: address,
        odd_turns: address,
        turn_count: u8,
        confirm_deck_player_one: ID,
        confirm_deck_player_two: ID,
        player_one_general_status: u8,
        player_one_monster_status: u8,
        player_one_rider_status: u8,
        player_one_soldier_status: u8,
        player_two_general_status: u8,
        player_two_monster_status: u8,
        player_two_rider_status: u8,
        player_two_soldier_status: u8,




       
    }




    // player with key has ability to make turn
    struct TurnKey has key, store {
        id: UID,
    }



   

    // starts game by:
    // taking a coin flip guess and is correct sending it to the player one address
    // if guess is not correct the turn key goes to player two
    // the game object makes all permanents alive
    public fun start_game(coin_flip_guess: u8, r: &Random, player_one_address: address, player_two_address: address,  confirm_deck_player_one: &ConfirmedDeck, confirm_deck_player_two: &ConfirmedDeck, ctx: &mut TxContext)  {

       let coin_flip_result = coin_toss(r, ctx);

       

        let start_address = @0x0;


        let game = Game {
            id: object::new(ctx),

            player_one_address,
            player_two_address,

            coin_flip_guess,
            coin_flip_count: 1,
            coin_flip_result,

            // set the player addresses based on the result of the coin flip guess
            even_turns: start_address,
            odd_turns: start_address,
            turn_count: 0,

            
            confirm_deck_player_one: object::id(confirm_deck_player_one),
            confirm_deck_player_two: object::id(confirm_deck_player_two),

            // 1 alive, 0 noot alive
            player_one_general_status: 1,
            player_one_monster_status: 1,
            player_one_rider_status: 1,
            player_one_soldier_status: 1,
            player_two_general_status: 1,
            player_two_monster_status: 1,
            player_two_rider_status: 1,
            player_two_soldier_status: 1,
           
        };


        if(game.coin_flip_result == game.coin_flip_guess){

            game.even_turns = player_one_address;
            game.odd_turns = player_two_address;


            let turn_key = TurnKey {
                id: object::new(ctx),
            };

            transfer::transfer(turn_key, player_one_address);
        } else {

            let turn_key = TurnKey {
                id: object::new(ctx),
            };

            transfer::transfer(turn_key, player_two_address);

            game.even_turns = player_two_address;
            game.odd_turns = player_one_address;

        };



        transfer::public_share_object(game);



    }




    // turn actions and deletes the HashedSelectionProved object
    // UNDER CONSTURCTION
    entry fun turn_trial(game: &mut Game, proven: HashedSelectionProved, ctx: &mut TxContext){

       


        if(proven.proved == true) {

            

            let HashedSelectionProved {id, proved: _} = proven;

            object::delete(id);

            // do turn actions .. 
            game.turn_count = game.turn_count + 1;
            
        } else {
            
            
            debug::print<bool>(&proven.proved);
            
            let HashedSelectionProved {id, proved: _} = proven;

            object::delete(id);

            // end turn and pass turn object to other player
        }
        

    }






    // mints first turn token amount
    public fun first_turn( cap: &mut TreasuryCap<MONSTI>, recipient: address, ctx: &mut TxContext) {

        first_turns_mint(cap, recipient, ctx);


    }



    struct HashedSelection has key, store {
        id: UID,
        hashed_selection: vector<u8>,
    }



    struct HashedSelectionProved has key, store {
        id: UID,
        proved: bool,
    }






    struct HashedSelectionMade has copy, drop {
        hash: vector<u8>,
    }



    struct HashedSelectionProvedMade has copy, drop {
        hash_proved: bool,
    }





    // takes a value and adds a salt then hashes it
    // this allows a player to make a guess and show the hash
    // then after all decisions are made the correct guesses are shown with the salt as proof
    // each time this is called a new salt is need to create then prove the hash
    public entry fun hashed_selection(choice: u8, salt: vector<u8>, ctx: &mut TxContext) {

        vector::push_back<u8>(&mut salt, choice);
        let hash = std::hash::sha2_256(salt);

        event::emit(
            HashedSelectionMade {
                hash
            }
        );


        let hash_selection = HashedSelection {
            id: object::new(ctx),
            hashed_selection: hash,
        };
        

        transfer::public_transfer(hash_selection, tx_context::sender(ctx))

    }





    // proves the salt and has of a previous hashed selection
    // gives sender a HashedSelectionProved object with the bool set to true.
    public entry fun prove_hashed_selection( hashed_selection: &HashedSelection, choice_selected: u8, salt_used: vector<u8>, ctx: &mut TxContext )  {

        let proved: bool = false;

        vector::push_back<u8>(&mut salt_used, choice_selected);
        let checked_hash = hash::sha2_256(salt_used);


        event::emit(
            HashedSelectionMade {
                hash: checked_hash,
            }
        );




        if( hashed_selection.hashed_selection == checked_hash) {

            proved = true;

            event::emit(
                HashedSelectionProvedMade {
                    hash_proved: true,
                }
            );

            let hash_proved = HashedSelectionProved {
                id: object::new(ctx),
                proved: proved,
            };

            transfer::public_transfer(hash_proved, tx_context::sender(ctx))

        } else {

            proved = false;

            event::emit(
                HashedSelectionProvedMade {
                    hash_proved: false,
                }
            );


            let hash_proved = HashedSelectionProved {
                id: object::new(ctx),
                proved: proved,
            };


            transfer::public_transfer(hash_proved, tx_context::sender(ctx))

        }

        

    }









    
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GAME GETTERS 
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    
    // player_one_address
    // player_two_address
    // coin_flip_guess
    // coin_flip_count
    // coin_flip_result
    // even_turns
    // odd_turns
    // turn_count
    // confirm_deck_player_one
    // confirm_deck_player_two
    // player_one_general_status
    // player_one_monster_status
    // player_one_rider_status
    // player_one_soldier_status
    // player_two_general_status
    // player_two_monster_status
    // player_two_rider_status
    // player_two_soldier_status



    // player one address
    public fun player_one_address(game: &Game) : address {

        let player_one_address = game.player_one_address;

        player_one_address
    }




    // player two address
    public fun player_two_address(game: &Game) : address {

        let player_two_address = game.player_two_address;

        player_two_address
    }



    // coin flip guess
    public fun coin_flip_guess(game: &Game) : u8 {

        let coin_flip_guess = game.coin_flip_guess;

        coin_flip_guess
    }


    // coin flip count
    public fun coin_flip_count(game: &Game) : u8 {

        let coin_flip_count = game.coin_flip_count;

        coin_flip_count
    }



    // coin flip result
    public fun coin_flip_result(game: &Game) : u8 {

        let coin_flip_result = game.coin_flip_result;

        coin_flip_result
    }



    // even turns
    public fun even_turns(game: &Game) : address {

        let even_turns = game.even_turns;

        even_turns
    }


    // odd turns
    public fun odd_turns(game: &Game) : address {

        let odd_turns = game.odd_turns;

        odd_turns
    }


    // turn count
    public fun turn_count(game: &Game) : u8 {

        let turn_count = game.turn_count;

        turn_count
    }



    // confirm deck player one
    public fun confirm_deck_player_one(game: &Game) : ID {

        let confirm_deck_player_one = game.confirm_deck_player_one;

        confirm_deck_player_one
    }


    // confirm deck player two
    public fun confirm_deck_player_two(game: &Game) : ID {

        let confirm_deck_player_two = game.confirm_deck_player_two;

        confirm_deck_player_two
    }



    // player one general status
    public fun player_one_general_status(game: &Game) : u8 {

        let player_one_general_status = game.player_one_general_status;

        player_one_general_status
    }


    // player one monster status
    public fun player_one_monster_status(game: &Game) : u8 {

        let player_one_monster_status = game.player_one_monster_status;

        player_one_monster_status
    }

    // player one rider status
    public fun player_one_rider_status(game: &Game) : u8 {

        let player_one_rider_status = game.player_one_rider_status;

        player_one_rider_status
    }

    // player one soldier status
    public fun player_one_soldier_status(game: &Game) : u8 {

        let player_one_soldier_status = game.player_one_soldier_status;

        player_one_soldier_status
    }

    // player two general status
    public fun player_two_general_status(game: &Game) : u8 {

        let player_two_general_status = game.player_two_general_status;

        player_two_general_status
    }

    // player two monster status
    public fun player_two_monster_status(game: &Game) : u8 {

        let player_two_monster_status = game.player_two_monster_status;

        player_two_monster_status
    }

    // player two rider status
    public fun player_two_rider_status(game: &Game) : u8 {

        let player_two_rider_status = game.player_two_rider_status;

        player_two_rider_status
    }

    // player two soldier status
    public fun player_two_soldier_status(game: &Game) : u8 {

        let player_two_soldier_status = game.player_two_soldier_status;

        player_two_soldier_status
    }



    





    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // COIN TOSS FUNCTIONS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------



    // 50% probability coin toss
    entry fun coin_toss(r: &Random, ctx: &mut TxContext) : u8 {

        let result = fifty_percent_probability(r, ctx);

        result

    }










    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------







    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // SOLDIER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------


    struct AttackSuccess has copy, drop, store {
        attack_success: bool,
    }


    struct AttackFail has copy, drop, store {
        attack_success: bool,
    }


    struct Death has copy, drop, store {
        death: bool,
    }



    
    // ADD CP COSTS
    // soldier vs soldier
    entry fun soldier_vs_soldier(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = soldier_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(soldier_defense.type_id == 4, 99);


        // checks cards are confirmed for gameplay
        if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
            attack_card_confirmed = true;
        };


        if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 50% probability of attack success
        if( fifty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            soldier_defense.health = soldier_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(soldier_defense.health == 0) {
            delete_card(soldier_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(soldier_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(soldier_attack, address_attacker);
        

        

    }



    

    // ADD CP COSTS
    // soldier vs rider
    entry fun soldier_vs_rider(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = rider_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(rider_defense.type_id == 3, 99);


        // checks cards are confirmed for gameplay
        if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
            attack_card_confirmed = true;
        };


        if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 40% probability of attack success
        if( forty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            rider_defense.health = rider_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(rider_defense.health == 0) {
            delete_card(rider_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(rider_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(soldier_attack, address_attacker);
        

        

    }




    // ADD CP COSTS
    // soldier vs monster
    entry fun soldier_vs_monster(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = monster_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(monster_defense.type_id == 2, 99);


        // checks cards are confirmed for gameplay
        if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
            attack_card_confirmed = true;
        };


        if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 33% probability of attack success
        if( thirty_three_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            monster_defense.health = monster_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(monster_defense.health == 0) {
            delete_card(monster_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(monster_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(soldier_attack, address_attacker);
        

        

    }






    // ADD CP COSTS
    // soldier vs general
    entry fun soldier_vs_general(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = general_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(general_defense.type_id == 1, 99);


        // checks cards are confirmed for gameplay
        if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
            attack_card_confirmed = true;
        };


        if(general_defense_confirmed.general_id == object::id(&general_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 66% probability of attack success
        if( sixty_six_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            general_defense.health = general_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(general_defense.health == 0) {
            delete_card(general_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(general_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(soldier_attack, address_attacker);
        

        

    }








    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // RIDER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // rider vs soldier
    entry fun rider_vs_soldier(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = soldier_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(soldier_defense.type_id == 4, 99);


        // checks cards are confirmed for gameplay
        if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
            attack_card_confirmed = true;
        };


        if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 60% probability of attack success
        if( sixty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            soldier_defense.health = soldier_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(soldier_defense.health == 0) {
            delete_card(soldier_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(soldier_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(rider_attack, address_attacker);
        

        

    }



    

    // ADD CP COSTS
    // rider vs rider
    entry fun rider_vs_rider(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = rider_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(rider_defense.type_id == 3, 99);


        // checks cards are confirmed for gameplay
        if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
            attack_card_confirmed = true;
        };


        if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 50% probability of attack success
        if( fifty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            rider_defense.health = rider_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(rider_defense.health == 0) {
            delete_card(rider_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(rider_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(rider_attack, address_attacker);
        

        

    }




    // ADD CP COSTS
    // rider vs monster
    entry fun rider_vs_monster(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = monster_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(monster_defense.type_id == 2, 99);


        // checks cards are confirmed for gameplay
        if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
            attack_card_confirmed = true;
        };


        if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 40% probability of attack success
        if( forty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            monster_defense.health = monster_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(monster_defense.health == 0) {
            delete_card(monster_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(monster_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(rider_attack, address_attacker);
        

        

    }






    // ADD CP COSTS
    // rider vs general
    entry fun rider_vs_general(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = general_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(general_defense.type_id == 1, 99);


        // checks cards are confirmed for gameplay
        if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
            attack_card_confirmed = true;
        };


        if(general_defense_confirmed.general_id == object::id(&general_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 75% probability of attack success
        if( seventy_five_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            general_defense.health = general_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(general_defense.health == 0) {
            delete_card(general_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(general_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(rider_attack, address_attacker);
        

        

    }











    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // MONSTER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // monster vs soldier
    entry fun monster_vs_soldier(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = soldier_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(soldier_defense.type_id == 4, 99);


        // checks cards are confirmed for gameplay
        if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
            attack_card_confirmed = true;
        };


        if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 60% probability of attack success
        if( sixty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            soldier_defense.health = soldier_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(soldier_defense.health == 0) {
            delete_card(soldier_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(soldier_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(monster_attack, address_attacker);
        

        

    }



    

    // ADD CP COSTS
    // monster vs rider
    entry fun monster_vs_rider(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = rider_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(rider_defense.type_id == 3, 99);


        // checks cards are confirmed for gameplay
        if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
            attack_card_confirmed = true;
        };


        if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 55% probability of attack success
        if( fifty_five_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            rider_defense.health = rider_defense.health - 1;
        event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(rider_defense.health == 0) {
            delete_card(rider_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(rider_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(monster_attack, address_attacker);
        

        

    }




    // ADD CP COSTS
    // monster vs monster
    entry fun monster_vs_monster(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = monster_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(monster_defense.type_id == 2, 99);


        // checks cards are confirmed for gameplay
        if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
            attack_card_confirmed = true;
        };


        if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 50% probability of attack success
        if( fifty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            monster_defense.health = monster_defense.health - 1;
        event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(monster_defense.health == 0) {
            delete_card(monster_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(monster_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(monster_attack, address_attacker);
        

        

    }






    // ADD CP COSTS
    // monster vs general
    entry fun monster_vs_general(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = general_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(general_defense.type_id == 1, 99);


        // checks cards are confirmed for gameplay
        if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
            attack_card_confirmed = true;
        };


        if(general_defense_confirmed.general_id == object::id(&general_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 80% probability of attack success
        if( eighty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            general_defense.health = general_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(general_defense.health == 0) {
            delete_card(general_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(general_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(monster_attack, address_attacker);
        

        

    }







    
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GENERAL ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // general vs soldier
    entry fun general_vs_soldier(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = soldier_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(soldier_defense.type_id == 4, 99);


        // checks cards are confirmed for gameplay
        if(general_attack_confirmed.general_id == object::id(&general_attack)){
            attack_card_confirmed = true;
        };


        if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 70% probability of attack success
        if( seventy_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            soldier_defense.health = soldier_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(soldier_defense.health == 0) {
            delete_card(soldier_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(soldier_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(general_attack, address_attacker);
        

        

    }



    

    // ADD CP COSTS
    // general vs rider
    entry fun general_vs_rider(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = rider_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(rider_defense.type_id == 3, 99);


        // checks cards are confirmed for gameplay
        if(general_attack_confirmed.general_id == object::id(&general_attack)){
            attack_card_confirmed = true;
        };


        if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 60% probability of attack success
        if( sixty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            rider_defense.health = rider_defense.health - 1;
            event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(rider_defense.health == 0) {
            delete_card(rider_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(rider_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(general_attack, address_attacker);
        

        

    }




    // ADD CP COSTS
    // general vs monster
    entry fun general_vs_monster(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = monster_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(monster_defense.type_id == 2, 99);


        // checks cards are confirmed for gameplay
        if(general_attack_confirmed.general_id == object::id(&general_attack)){
            attack_card_confirmed = true;
        };


        if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 556% probability of attack success
        if( fifty_five_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            monster_defense.health = monster_defense.health - 1;
        event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(monster_defense.health == 0) {
            delete_card(monster_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(monster_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(general_attack, address_attacker);
        

        

    }






    // ADD CP COSTS
    // general vs general
    entry fun general_vs_general(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = general_defense.owner_address;
        let attack_card_confirmed = false;
        let defense_card_confirmed = false;
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(general_defense.type_id == 1, 99);


        // checks cards are confirmed for gameplay
        if(general_attack_confirmed.general_id == object::id(&general_attack)){
            attack_card_confirmed = true;
        };


        if(general_defense_confirmed.general_id == object::id(&general_defense)){
            defense_card_confirmed = true;
        };


        assert!(attack_card_confirmed == true, 99);
        assert!(defense_card_confirmed == true, 99);




        // 80% probability of attack success
        if( eighty_percent_probability(r, ctx) == 1) {
            successful = true;
        };


        // if successful, decrease health of defense card by 1
        if(successful == true) {
            general_defense.health = general_defense.health - 1;
        event::emit(AttackSuccess {
                attack_success: true,
            });
        } else {
            event::emit(AttackFail {
                attack_success: false,
            });
        };



        // if defense card health is 0, delete card
        if(general_defense.health == 0) {
            delete_card(general_defense);
            event::emit(Death {
                death: true,
            });
        }  else {

            // public transfer defense card back to player
            transfer::public_transfer(general_defense, address_defender);

        };
        



        // public transfer attack card back to player
        transfer::public_transfer(general_attack, address_attacker);
        

        

    }





























    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // DEFENSE FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------


    struct FrontLineDefense has copy, drop, store {
        value: u8,
        result: u8,
    }



    // frontline defense stance
    // free CP
    // returns 1 for general, 2 for monster, 3 for rider, 4 for soldier
    // will indicate which permenant is being attacked
    // 25% probability for each permenant
    entry fun frontline_defense_stance(r: &Random, ctx: &mut TxContext) : u8 {

        
        let general = 0;
        let monster = 0;
        let rider = 0;
        let soldier = 0;



        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        if (v <= 25) {
            general = 1;
        }; 

        if (v > 25 && v <= 50 ) {
            monster = 1;
        }; 

        if (v > 50 && v <= 75) {
            rider = 1;
        }; 

        if (v > 75 && v <= 100) {
            soldier = 1;
        };



        let result = 0;

        if(general == 1){
            result = 1;
        }; 

        if(monster == 1) {
            result = 2;
        }; 

        if(rider == 1) {
            result = 3;
        };  

        if(soldier == 1) {
            result = 4;
        };


        event::emit(FrontLineDefense {
            value: v,
            result: result,
        });


        
        

        result

    }



    struct BackLineDefense has copy, drop, store {
        value: u8,
        result: u8,
    }



    // backline defense stance
    // add 1 CP cost
    // returns 1 for general, 2 for monster, 3 for rider, 4 for soldier
    // will indicate which permenant is being attacked
    // 5% probability for general, 5% for monster, 15% for rider, 75% for soldier
    entry fun backline_defense_stance(r: &Random, ctx: &mut TxContext) : u8 {

        
        let general = 0;
        let monster = 0;
        let rider = 0;
        let soldier = 0;



        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        if (v > 95 && v <= 100 ) {
            general = 1;
        }; 

        if (v > 90 && v <= 95 ) {
            monster = 1;
        }; 

        if (v > 75 && v <= 90) {
            rider = 1;
        }; 

        if (v <= 75) {
            soldier = 1;
        };



        let result = 0;

        if(general == 1){
            result = 1;
        }; 

        if(monster == 1) {
            result = 2;
        }; 

        if(rider == 1) {
            result = 3;
        };  

        if(soldier == 1) {
            result = 4;
        };




        event::emit(BackLineDefense {
            value: v,
            result: result,
        });
        

        result

    }







    struct RandNum has key, store {
        id: UID,
        value: u8,
        bool_value: bool,
    }









    // ----------------------------------
    // PROBABILITY FUNCTIONS
    // ----------------------------------




    // 25% probability
    entry fun twenty_five_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 25%
        let twenty_five_percent = arithmetic_is_less_than(v, 26, 100); 

        if(twenty_five_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        twenty_five_percent


    }


    


    // 33% probability
    entry fun thirty_three_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 33%
        let thirty_three_percent = arithmetic_is_less_than(v, 34, 100); 


        if(thirty_three_percent == 1) {
            result = true;
        };



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        thirty_three_percent


    }



    // 40% probability
    entry fun forty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 40%
        let forty_percent = arithmetic_is_less_than(v, 41, 100); 


        if(forty_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        forty_percent


    }




    // 50% probability
    entry fun fifty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 50%
        let fifty_percent = arithmetic_is_less_than(v, 51, 100); 



        if(fifty_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        fifty_percent


    }




    // 55% probability
    entry fun fifty_five_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 55%
        let fifty_five_percent = arithmetic_is_less_than(v, 56, 100);



        if(fifty_five_percent == 1) {
            result = true;
        }; 


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        fifty_five_percent


    }




    // 60% probability
    entry fun sixty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 60%
        let sixty_percent = arithmetic_is_less_than(v, 61, 100); 


        if(sixty_percent == 1) {
            result = true;
        }; 


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        sixty_percent


    }



    // 66% probability
    entry fun sixty_six_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 66%
        let sixty_six_percent = arithmetic_is_less_than(v, 67, 100); 


        if(sixty_six_percent == 1) {
            result = true;
        }; 



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        sixty_six_percent


    }



    // 70% probability
    entry fun seventy_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 70%
        let seventy_percent = arithmetic_is_less_than(v, 71, 100); 


        if(seventy_percent == 1) {
            result = true;
        }; 



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        seventy_percent


    }



    // 75% probability
    entry fun seventy_five_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);



        // probability of 75%
        let seventy_five_percent = arithmetic_is_less_than(v, 76, 100); 



        if(seventy_five_percent == 1) {
            result = true;
        }; 



        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        seventy_five_percent


    }




    // 80% probability
    entry fun eighty_percent_probability(r: &Random, ctx: &mut TxContext ) : u8 {

        let result: bool = false;

        let generator = new_generator(r, ctx);
        let v = random::generate_u8_in_range(&mut generator, 1, 100);


        // probability of 80%
        let eighty_percent = arithmetic_is_less_than(v, 81, 100); 


        if(eighty_percent == 1) {
            result = true;
        };


        let result = RandNum {
            id: object::new(ctx),
            value: v,
            bool_value: result,
        };

        transfer::public_share_object(result);


        eighty_percent


    }








    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // TIME FUNCTIONS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------





    // event to get time from a timestamp_ms
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64
    }





    public fun get_time(clock: &Clock)  {
        event::emit(TimeEvent {
            timestamp_ms: clock::timestamp_ms(clock),
        });

    }





















    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // TEST INIT
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------



    #[test_only]
    public fun init_for_testing(otw: CARD_DECK, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}




