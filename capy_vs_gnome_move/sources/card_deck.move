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


    // #[test_only]
    // friend capy_vs_gnome::card_deck_tests_attacks;
    // #[test_only]
    // friend capy_vs_gnome::card_deck_tests_getters;










    // CONTENTS:
    // PERMENANTS CARDS 
    //   - Card
    //   - delete_card
    //   - GnomeGeneralOwnerCap
    //   - delete_gnome_general_owner_cap
    //   - GnomeGeneral
    //   - mint_gnome_general
    //   - transfer_gnome_general
    //    
    //   - GnomeMonsterOwnerCap
    //   - delete_gnome_monster_owner_cap
    //   - GnomeMonster
    //   - mint_gnome_monster
    //   - transfer_gnome_monster
    //    
    //   - GnomeRiderOwnerCap
    //   - delete_gnome_rider_owner_cap
    //   - GnomeRider
    //   - mint_gnome_rider
    //   - transfer_gnome_rider
    //   
    //   - GnomeSodierOwnerCap
    //   - delete_gnome_soldier_owner_cap
    //   - GnomeSoldier
    //   - mint_gnome_soldier
    //   - transfer_gnome_soldier
    //    
    //   - CapyGeneralOwnerCap
    //   - delete_capy_general_owner_cap
    //   - CapyGeneral
    //   - mint_capy_general
    //   - transfer_capy_general
    //    
    //   - CapyMonsterOwnerCap
    //   - delete_capy_monster_owner_cap
    //   - CapyMonster
    //   - mint_capy_monster
    //   - transfer_capy_monster
    //    
    //   - CapyRiderOwnerCap
    //   - delete_capy_rider_owner_cap
    //   - CapyRider
    //   - mint_capy_rider
    //   - transfer_capy_rider
    //    
    //   - CapySodierOwnerCap
    //   - delete_capy_soldier_owner_cap
    //   - CapySoldier
    //   - mint_capy_soldier
    //   - transfer_capy_soldier
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
    //   - owner_address_gnome_general
    //   - owner_address_gnome_monster
    //   - owner_address_gnome_rider
    //   - owner_address_gnome_soldier
    //   
    //   - type_gnome_general
    //   - type_gnome_monster
    //   - type_gnome_rider
    //   - type_gnome_soldier
    //   
    //   - type_id_gnome_general
    //   - type_id_gnome_monster
    //   - type_id_gnome_rider
    //   - type_id_gnome_soldier
    //  
    //   - name_gnome_general
    //   - name_gnome_monster
    //   - name_gnome_rider
    //   - name_gnome_soldier
    //  
    //   - image_url_gnome_general
    //   - image_url_gnome_monster
    //   - image_url_gnome_rider
    //   - image_url_gnome_soldier
    //   
    //   - attack_gnome_general
    //   - attack_gnome_monster
    //   - attack_gnome_rider
    //   - attack_gnome_soldier
    //   
    //   - defense_gnome_general
    //   - defense_gnome_monster
    //   - defense_gnome_rider
    //   - defense_gnome_soldier
    //   
    //   - health_gnome_general
    //   - health_gnome_monster
    //   - health_gnome_rider
    //   - health_gnome_soldier
    //   
    //   - cost_gnome_general
    //   - cost_gnome_monster
    //   - cost_gnome_rider
    //   - cost_gnome_soldier
    //   
    //   - owner_address_capy_general
    //   - owner_address_capy_monster
    //   - owner_address_capy_rider
    //   - owner_address_capy_soldier
    //    
    //   - type_capy_general
    //   - type_capy_monster
    //   - type_capy_rider
    //   - type_capy_soldier
    //    
    //   - type_id_capy_general
    //   - type_id_capy_monster
    //   - type_id_capy_rider
    //   - type_id_capy_soldier
    //    
    //   - name_capy_general
    //   - name_capy_monster
    //   - name_capy_rider
    //   - name_capy_soldier
    //    
    //   - image_url_capy_general
    //   - image_url_capy_monster
    //   - image_url_capy_rider
    //   - image_url_capy_soldier
    //    
    //   - attack_capy_general
    //   - attack_capy_monster
    //   - attack_capy_rider
    //   - attack_capy_soldier
    //    
    //   - defense_capy_general
    //   - defense_capy_monster
    //   - defense_capy_rider
    //   - defense_capy_soldier
    //    
    //   - health_capy_general
    //   - health_capy_monster
    //   - health_capy_rider
    //   - health_capy_soldier
    //    
    //   - cost_capy_general
    //   - cost_capy_monster
    //   - cost_capy_rider
    //   - cost_capy_soldier
    //    
    // INIT
    //   - init
    // MINT DECKS
    //   - mint_gnome_cards
    //   - transfer_gnome_cards
    //   - delete_all_gnome_card_caps
    //   - mint_capy_cards
    //   - transfer_capy_cards
    //   - delete_all_capy_card_caps
    // CONFIRM DECKS
    //   - confirm_gnome_deck
    //   - confirm_capy_deck
    // GAME SETUP
    //    - Game
    //    - GameStatsEvent
    //    - emit_game_stats_event
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
    // ATTACK AND DEFEND FOR TURN STRUCTURE
    //    - attack_generic
    //    - DefenseCardAttacked
    //    - defensive_posture
    //    - attack_defend
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
    // END OF GAME CHECKS
    //    - Winner
    //    - game_over
    // COIN TOSS FUNCTIONS
    //   - coin_toss
    // ATTACK FUNCTIONS
    //   - soldier_vs_soldier 
    //   - soldier_vs_rider
    //   - soldier_vs_monster
    //   - soldier_vs_general
    //   - rider_vs_soldier 
    //   - rider_vs_rider
    //   - rider_vs_monster
    //   - rider_vs_general
    //   - monster_vs_soldier 
    //   - monster_vs_rider
    //   - monster_vs_monster
    //   - monster_vs_general
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
    //
    //
    // UNDER CONSTRUCTION
    //   - marks current work location










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


      









    
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GNOME CARDS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    // Gnome General Owner Cap
    struct GnomeGeneralOwnerCap has key, store {
        id: UID,
        gnome_general_id: ID,
    }


    public fun delete_gnome_general_owner_cap(cap: GnomeGeneralOwnerCap) {

        let GnomeGeneralOwnerCap { id, gnome_general_id: _} = cap;
        object::delete(id);

    }



    struct GnomeGeneral has key, store {
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



    fun mint_gnome_general(ctx: &mut TxContext) : GnomeGeneralOwnerCap {
        



        let gnome_general = GnomeGeneral {
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
            
        };


        let gnome_general_cap = GnomeGeneralOwnerCap {
            id: object::new(ctx),
            gnome_general_id: object::id(&gnome_general),
        };


        transfer::public_share_object(gnome_general);

        gnome_general_cap


    }



    fun transfer_gnome_general(ctx: &mut TxContext) {


        
        let gnome_general = GnomeGeneral {

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
            
        };


        let gnome_general_cap = GnomeGeneralOwnerCap {
            id: object::new(ctx),
            gnome_general_id: object::id(&gnome_general),
        };


        transfer::public_share_object(gnome_general);



        transfer::public_transfer(gnome_general_cap, tx_context::sender(ctx));

    }



    



    // Gnome Monster Owner Cap
    struct GnomeMonsterOwnerCap has key, store {
        id: UID,
        gnome_monster_id: ID,
    }


    public fun delete_gnome_monster_owner_cap(cap: GnomeMonsterOwnerCap) {

        let GnomeMonsterOwnerCap { id, gnome_monster_id: _} = cap;
        object::delete(id);

    }


    struct GnomeMonster has key, store {
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



    fun mint_gnome_monster(ctx: &mut TxContext) : GnomeMonsterOwnerCap {

        let gnome_monster = GnomeMonster {
            id: object::new(ctx),
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

        let gnome_monster_cap = GnomeMonsterOwnerCap {
            id: object::new(ctx),
            gnome_monster_id: object::id(&gnome_monster),
        };


        transfer::public_share_object(gnome_monster);

        gnome_monster_cap

    }



    fun transfer_gnome_monster(ctx: &mut TxContext) {

       let gnome_monster = GnomeMonster {
            id: object::new(ctx),
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

        let gnome_monster_cap = GnomeMonsterOwnerCap {
            id: object::new(ctx),
            gnome_monster_id: object::id(&gnome_monster),
        };


        transfer::public_share_object(gnome_monster);

        

        transfer::public_transfer(gnome_monster_cap, tx_context::sender(ctx));
    }


    
    // Gnome Rider Owner Cap
    struct GnomeRiderOwnerCap has key, store {
        id: UID,
        gnome_rider_id: ID,
    }


    public fun delete_gnome_rider_owner_cap(cap: GnomeRiderOwnerCap) {

        let GnomeRiderOwnerCap { id, gnome_rider_id: _} = cap;
        object::delete(id);

    }



    struct GnomeRider has key, store {
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


    fun mint_gnome_rider(ctx: &mut TxContext) : GnomeRiderOwnerCap {

        

        let gnome_rider = GnomeRider {
            id: object::new(ctx),
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


        let gnome_rider_cap = GnomeRiderOwnerCap {
            id: object::new(ctx),
            gnome_rider_id: object::id(&gnome_rider),
        };


        transfer::public_share_object(gnome_rider);

        gnome_rider_cap


    }


    fun transfer_gnome_rider(ctx: &mut TxContext) {

        let gnome_rider = GnomeRider {
            id: object::new(ctx),
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


        let gnome_rider_cap = GnomeRiderOwnerCap {
            id: object::new(ctx),
            gnome_rider_id: object::id(&gnome_rider),
        };


        transfer::public_share_object(gnome_rider);

        
        transfer::public_transfer(gnome_rider_cap, tx_context::sender(ctx));
    }


    
    // Gnome Soldier Owner Cap
    struct GnomeSoldierOwnerCap has key, store {
        id: UID,
        gnome_soldier_id: ID,
    }


    public fun delete_gnome_soldier_owner_cap(cap: GnomeSoldierOwnerCap) {

        let GnomeSoldierOwnerCap { id, gnome_soldier_id: _} = cap;
        object::delete(id);

    }



    struct GnomeSoldier has key, store {
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



    fun mint_gnome_soldier(ctx: &mut TxContext) : GnomeSoldierOwnerCap {
       

        let gnome_soldier = GnomeSoldier {
            id: object::new(ctx),
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
        };


        let gnome_soldier_cap = GnomeSoldierOwnerCap {
            id: object::new(ctx),
            gnome_soldier_id: object::id(&gnome_soldier),
        };


        transfer::public_share_object(gnome_soldier);

        gnome_soldier_cap

    }


    fun transfer_gnome_soldier(ctx: &mut TxContext) {
        
        let gnome_soldier = GnomeSoldier {
            id: object::new(ctx),
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
        };


         let gnome_soldier_cap = GnomeSoldierOwnerCap {
            id: object::new(ctx),
            gnome_soldier_id: object::id(&gnome_soldier),
        };


        transfer::public_share_object(gnome_soldier);

        

        transfer::public_transfer(gnome_soldier_cap, tx_context::sender(ctx));
    }


    




    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CAPYBARA CARDS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


   
    // Capy General Owner Cap
    struct CapyGeneralOwnerCap has key, store {
        id: UID,
        capy_general_id: ID,
    }


    public fun delete_capy_general_owner_cap(cap: CapyGeneralOwnerCap) {

        let CapyGeneralOwnerCap { id, capy_general_id: _} = cap;
        object::delete(id);

    }


    struct CapyGeneral has key, store {
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



    fun mint_capy_general(ctx: &mut TxContext) : CapyGeneralOwnerCap {

        let capy_general = CapyGeneral {

            id: object::new(ctx),
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
        };


        let capy_general_cap = CapyGeneralOwnerCap {
            id: object::new(ctx),
            capy_general_id: object::id(&capy_general),
        };


        transfer::public_share_object(capy_general);

        capy_general_cap




    }


    fun transfer_capy_general(ctx: &mut TxContext) {

        let capy_general = CapyGeneral {
            
            id: object::new(ctx),
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
        };


        let capy_general_cap = CapyGeneralOwnerCap {
            id: object::new(ctx),
            capy_general_id: object::id(&capy_general),
        };


        transfer::public_share_object(capy_general);

        
        transfer::public_transfer(capy_general_cap, tx_context::sender(ctx));

    }


    

    // Capy Monster Owner Cap
    struct CapyMonsterOwnerCap has key, store {
        id: UID,
        capy_monster_id: ID,
    }


    public fun delete_capy_monster_owner_cap(cap: CapyMonsterOwnerCap) {

        let CapyMonsterOwnerCap { id, capy_monster_id: _} = cap;
        object::delete(id);

    }



    struct CapyMonster has key, store {
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



    fun mint_capy_monster(ctx: &mut TxContext) : CapyMonsterOwnerCap {

        let capy_monster = CapyMonster {
            id: object::new(ctx),
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



        let capy_monster_cap = CapyMonsterOwnerCap {
            id: object::new(ctx),
            capy_monster_id: object::id(&capy_monster),
        };


        transfer::public_share_object(capy_monster);

        capy_monster_cap


    }


    fun transfer_capy_monster(ctx: &mut TxContext) {
        let capy_monster = CapyMonster {
            id: object::new(ctx),
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



        let capy_monster_cap = CapyMonsterOwnerCap {
            id: object::new(ctx),
            capy_monster_id: object::id(&capy_monster),
        };


        transfer::public_share_object(capy_monster);

    
        transfer::public_transfer(capy_monster_cap, tx_context::sender(ctx));
    }




    // Capy Rider Owner Cap
    struct CapyRiderOwnerCap has key, store {
        id: UID,
        capy_rider_id: ID,
    }


    public fun delete_capy_rider_owner_cap(cap: CapyRiderOwnerCap) {

        let CapyRiderOwnerCap { id, capy_rider_id: _} = cap;
        object::delete(id);

    }


    struct CapyRider has key, store {
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



    fun mint_capy_rider(ctx: &mut TxContext) : CapyRiderOwnerCap {
        

        let capy_rider = CapyRider {
            id: object::new(ctx),
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

        let capy_rider_cap = CapyRiderOwnerCap {
            id: object::new(ctx),
            capy_rider_id: object::id(&capy_rider),
        };


        transfer::public_share_object(capy_rider);

        capy_rider_cap
    }



    fun transfer_capy_rider(ctx: &mut TxContext) {
        let capy_rider = CapyRider {
            id: object::new(ctx),
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

        let capy_rider_cap = CapyRiderOwnerCap {
            id: object::new(ctx),
            capy_rider_id: object::id(&capy_rider),
        };


        transfer::public_share_object(capy_rider);

        
        transfer::public_transfer(capy_rider_cap, tx_context::sender(ctx));

    }


   


     // Capy Soldier Owner Cap
    struct CapySoldierOwnerCap has key, store {
        id: UID,
        capy_soldier_id: ID,
    }


    public fun delete_capy_soldier_owner_cap(cap: CapySoldierOwnerCap) {

        let CapySoldierOwnerCap { id, capy_soldier_id: _} = cap;
        object::delete(id);

    }


    struct CapySoldier has key, store {
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


    fun mint_capy_soldier(ctx: &mut TxContext) : CapySoldierOwnerCap {

        let capy_soldier = CapySoldier {
            id: object::new(ctx),
            owner_address: tx_context::sender(ctx),
            // gnome_soldier_id: object::uid_to_inner(&id),
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



        let capy_soldier_cap = CapySoldierOwnerCap {
            id: object::new(ctx),
            capy_soldier_id: object::id(&capy_soldier),
        };


        transfer::public_share_object(capy_soldier);

        capy_soldier_cap




    }


    fun transfer_capy_soldier(ctx: &mut TxContext) {

        let capy_soldier = CapySoldier {
            id: object::new(ctx),
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
        };


        let capy_soldier_cap = CapySoldierOwnerCap {
            id: object::new(ctx),
            capy_soldier_id: object::id(&capy_soldier),
        };


        transfer::public_share_object(capy_soldier);

        


        transfer::public_transfer(capy_soldier_cap, tx_context::sender(ctx));
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



    // owner address
    public fun owner_address_gnome_general(card: &GnomeGeneral) : address {

        let address = card.owner_address;

        address
    }

    public fun owner_address_gnome_monster(card: &GnomeMonster) : address {

        let address = card.owner_address;

        address
    }

    public fun owner_address_gnome_rider(card: &GnomeRider) : address {

        let address = card.owner_address;

        address
    }

    public fun owner_address_gnome_soldier(card: &GnomeSoldier) : address {

        let address = card.owner_address;

        address
    }




    // type
    public fun type_gnome_general(card: &GnomeGeneral) : String {

        let t = card.type;
       
        t
    }


    public fun type_gnome_monster(card: &GnomeMonster) : String {

        let t = card.type;
       
        t
    }


    public fun type_gnome_rider(card: &GnomeRider) : String {

        let t = card.type;
       
        t
    }


    public fun type_gnome_soldier(card: &GnomeSoldier) : String {

        let t = card.type;
       
        t
    }



    // type id
    public fun type_id_gnome_general(card: &GnomeGeneral) : u64 {

        let t = card.type_id;
       
        t
    }


    public fun type_id_gnome_monster(card: &GnomeMonster) : u64 {

        let t = card.type_id;
       
        t
    }


    public fun type_id_gnome_rider(card: &GnomeRider) : u64 {

        let t = card.type_id;
       
        t
    }


    public fun type_id_gnome_soldier(card: &GnomeSoldier) : u64 {

        let t = card.type_id;
       
        t
    }


    // name 
    public fun name_gnome_general(card: &GnomeGeneral) : String {

        let name = card.name;
       
        name
    }


    public fun name_gnome_monster(card: &GnomeMonster) : String {

        let name = card.name;
       
        name
    }


    public fun name_gnome_rider(card: &GnomeRider) : String {

        let name = card.name;
       
        name
    }



    public fun name_gnome_soldier(card: &GnomeSoldier) : String {

        let name = card.name;
       
        name
    }


    // img url
    public fun image_url_gnome_general(card: &GnomeGeneral) : String {

        let image_url = card.image_url;
       
        image_url
    }

    

    public fun image_url_gnome_monster(card: &GnomeMonster) : String {

        let image_url = card.image_url;
       
        image_url
    }


    public fun image_url_gnome_rider(card: &GnomeRider) : String {

        let image_url = card.image_url;
       
        image_url
    }

    public fun image_url_gnome_soldier(card: &GnomeSoldier) : String {

        let image_url = card.image_url;
       
        image_url
    }




    // attack 
    public fun attack_gnome_general(card: &GnomeGeneral) : u64 {

        let attack = card.attack;
       
        attack
    }


    public fun attack_gnome_monster(card: &GnomeMonster) : u64 {

        let attack = card.attack;
       
        attack
    }


    public fun attack_gnome_rider(card: &GnomeRider) : u64 {

        let attack = card.attack;
       
        attack
    }


    public fun attack_gnome_soldier(card: &GnomeSoldier) : u64 {

        let attack = card.attack;
       
        attack
    }



    // defense
    public fun defense_gnome_general(card: &GnomeGeneral) : u64 {

        let defense = card.defense;
       
        defense
    }

    public fun defense_gnome_monster(card: &GnomeMonster) : u64 {

        let defense = card.defense;
       
        defense
    }


    public fun defense_gnome_rider(card: &GnomeRider) : u64 {

        let defense = card.defense;
       
        defense
    }


    public fun defense_gnome_soldier(card: &GnomeSoldier) : u64 {

        let defense = card.defense;
       
        defense
    }



    // health
    public fun health_gnome_general(card: &GnomeGeneral) : u64 {

        let health = card.health;
       
        health
    }


    public fun health_gnome_monster(card: &GnomeMonster) : u64 {

        let health = card.health;
       
        health
    }


    public fun health_gnome_rider(card: &GnomeRider) : u64 {

        let health = card.health;
       
        health
    }


    public fun health_gnome_soldier(card: &GnomeSoldier) : u64 {

        let health = card.health;
       
        health
    }






    // cost
    public fun cost_gnome_general(card: &GnomeGeneral) : u64 {

        let cost = card.cost;
       
        cost
    }

    public fun cost_gnome_monster(card: &GnomeMonster) : u64 {

        let cost = card.cost;
       
        cost
    }

    public fun cost_gnome_rider(card: &GnomeRider) : u64 {

        let cost = card.cost;
       
        cost
    }

    public fun cost_gnome_soldier(card: &GnomeSoldier) : u64 {

        let cost = card.cost;
       
        cost
    }






    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CAPY GETTERS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    
    // owner address
    public fun owner_address_capy_general(card: &CapyGeneral) : address {

        let address = card.owner_address;

        address
    }

    public fun owner_address_capy_monster(card: &CapyMonster) : address {

        let address = card.owner_address;

        address
    }

    public fun owner_address_capy_rider(card: &CapyRider) : address {

        let address = card.owner_address;

        address
    }

    public fun owner_address_capy_soldier(card: &CapySoldier) : address {

        let address = card.owner_address;

        address
    }




    // type
    public fun type_capy_general(card: &CapyGeneral) : String {

        let t = card.type;
       
        t
    }


    public fun type_capy_monster(card: &CapyMonster) : String {

        let t = card.type;
       
        t
    }


    public fun type_capy_rider(card: &CapyRider) : String {

        let t = card.type;
       
        t
    }


    public fun type_capy_soldier(card: &CapySoldier) : String {

        let t = card.type;
       
        t
    }



    // type id
    public fun type_id_capy_general(card: &CapyGeneral) : u64 {

        let t = card.type_id;
       
        t
    }


    public fun type_id_capy_monster(card: &CapyMonster) : u64 {

        let t = card.type_id;
       
        t
    }


    public fun type_id_capy_rider(card: &CapyRider) : u64 {

        let t = card.type_id;
       
        t
    }


    public fun type_id_capy_soldier(card: &CapySoldier) : u64 {

        let t = card.type_id;
       
        t
    }


    // name 
    public fun name_capy_general(card: &CapyGeneral) : String {

        let name = card.name;
       
        name
    }


    public fun name_capy_monster(card: &CapyMonster) : String {

        let name = card.name;
       
        name
    }


    public fun name_capy_rider(card: &CapyRider) : String {

        let name = card.name;
       
        name
    }



    public fun name_capy_soldier(card: &CapySoldier) : String {

        let name = card.name;
       
        name
    }


    // img url
    public fun image_url_capy_general(card: &CapyGeneral) : String {

        let image_url = card.image_url;
       
        image_url
    }

    

    public fun image_url_capy_monster(card: &CapyMonster) : String {

        let image_url = card.image_url;
       
        image_url
    }


    public fun image_url_capy_rider(card: &CapyRider) : String {

        let image_url = card.image_url;
       
        image_url
    }

    public fun image_url_capy_soldier(card: &CapySoldier) : String {

        let image_url = card.image_url;
       
        image_url
    }




    // attack 
    public fun attack_capy_general(card: &CapyGeneral) : u64 {

        let attack = card.attack;
       
        attack
    }


    public fun attack_capy_monster(card: &CapyMonster) : u64 {

        let attack = card.attack;
       
        attack
    }


    public fun attack_capy_rider(card: &CapyRider) : u64 {

        let attack = card.attack;
       
        attack
    }


    public fun attack_capy_soldier(card: &CapySoldier) : u64 {

        let attack = card.attack;
       
        attack
    }



    // defense
    public fun defense_capy_general(card: &CapyGeneral) : u64 {

        let defense = card.defense;
       
        defense
    }

    public fun defense_capy_monster(card: &CapyMonster) : u64 {

        let defense = card.defense;
       
        defense
    }


    public fun defense_capy_rider(card: &CapyRider) : u64 {

        let defense = card.defense;
       
        defense
    }


    public fun defense_capy_soldier(card: &CapySoldier) : u64 {

        let defense = card.defense;
       
        defense
    }



    // health
    public fun health_capy_general(card: &CapyGeneral) : u64 {

        let health = card.health;
       
        health
    }


    public fun health_capy_monster(card: &CapyMonster) : u64 {

        let health = card.health;
       
        health
    }


    public fun health_capy_rider(card: &CapyRider) : u64 {

        let health = card.health;
       
        health
    }


    public fun health_capy_soldier(card: &CapySoldier) : u64 {

        let health = card.health;
       
        health
    }






    // cost
    public fun cost_capy_general(card: &CapyGeneral) : u64 {

        let cost = card.cost;
       
        cost
    }

    public fun cost_capy_monster(card: &CapyMonster) : u64 {

        let cost = card.cost;
       
        cost
    }

    public fun cost_capy_rider(card: &CapyRider) : u64 {

        let cost = card.cost;
       
        cost
    }

    public fun cost_capy_soldier(card: &CapySoldier) : u64 {

        let cost = card.cost;
       
        cost
    }







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
        
    


    }












    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // MINT DECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------












     // GNOME DECK

    public fun mint_gnome_cards(ctx: &mut TxContext) : (GnomeGeneralOwnerCap, GnomeMonsterOwnerCap, GnomeRiderOwnerCap, GnomeSoldierOwnerCap) {

        
        
        let gnome_general_owner_cap = mint_gnome_general(ctx);
        let gnome_monster_owner_cap = mint_gnome_monster(ctx);
        let gnome_rider_owner_cap = mint_gnome_rider(ctx);
        let gnome_soldier_owner_cap = mint_gnome_soldier(ctx);
      


        (gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap)      


    } 
    



    public entry fun transfer_gnome_cards(ctx: &mut TxContext) {
            
            let gnome_general_owner_cap = mint_gnome_general(ctx);
            let gnome_monster_owner_cap = mint_gnome_monster(ctx);
            let gnome_rider_owner_cap = mint_gnome_rider(ctx);
            let gnome_soldier_owner_cap = mint_gnome_soldier(ctx);
    
            transfer::public_transfer(gnome_general_owner_cap, tx_context::sender(ctx));
            transfer::public_transfer(gnome_monster_owner_cap, tx_context::sender(ctx));
            transfer::public_transfer(gnome_rider_owner_cap, tx_context::sender(ctx));
            transfer::public_transfer(gnome_soldier_owner_cap, tx_context::sender(ctx));

    }







    



    public entry fun delete_all_gnome_card_caps(gnome_general_owner_cap: GnomeGeneralOwnerCap, gnome_monster_owner_cap: GnomeMonsterOwnerCap, gnome_rider_owner_cap: GnomeRiderOwnerCap, gnome_soldier_owner_cap: GnomeSoldierOwnerCap, ctx: &mut TxContext) {
        
        delete_gnome_general_owner_cap(gnome_general_owner_cap);
        delete_gnome_monster_owner_cap(gnome_monster_owner_cap);
        delete_gnome_rider_owner_cap(gnome_rider_owner_cap);
        delete_gnome_soldier_owner_cap(gnome_soldier_owner_cap);

      
    }






    
    // CAPY DECK



    public fun mint_capy_cards(ctx: &mut TxContext) : (CapyGeneralOwnerCap, CapyMonsterOwnerCap, CapyRiderOwnerCap, CapySoldierOwnerCap) {

        
        
        let capy_general_owner_cap = mint_capy_general(ctx);
        let capy_monster_owner_cap = mint_capy_monster(ctx);
        let capy_rider_owner_cap = mint_capy_rider(ctx);
        let capy_soldier_owner_cap = mint_capy_soldier(ctx);
      


        (capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap)      


    } 

    


    public entry fun transfer_capy_cards(ctx: &mut TxContext) {

        let capy_general_owner_cap = mint_capy_general(ctx);
        let capy_monster_owner_cap = mint_capy_monster(ctx);
        let capy_rider_owner_cap = mint_capy_rider(ctx);
        let capy_soldier_owner_cap = mint_capy_soldier(ctx);

        transfer::public_transfer(capy_general_owner_cap, tx_context::sender(ctx));
        transfer::public_transfer(capy_monster_owner_cap, tx_context::sender(ctx));
        transfer::public_transfer(capy_rider_owner_cap, tx_context::sender(ctx));
        transfer::public_transfer(capy_soldier_owner_cap, tx_context::sender(ctx));

    }






    public entry fun delete_all_capy_card_caps(capy_general_owner_cap: CapyGeneralOwnerCap, capy_monster_owner_cap: CapyMonsterOwnerCap, capy_rider_owner_cap: CapyRiderOwnerCap, capy_soldier_owner_cap: CapySoldierOwnerCap, ctx: &mut TxContext) {
        
        delete_capy_general_owner_cap(capy_general_owner_cap);
        delete_capy_monster_owner_cap(capy_monster_owner_cap);
        delete_capy_rider_owner_cap(capy_rider_owner_cap);
        delete_capy_soldier_owner_cap(capy_soldier_owner_cap);

      
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




    // ensures the players are using an accurate deck and correct cards during gameplay
    public entry fun confirm_gnome_deck( general: GnomeGeneral, monster: GnomeMonster, rider: GnomeRider, soldier: GnomeSoldier, ctx: &mut TxContext) {


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

        transfer::public_share_object(general);
        transfer::public_share_object(monster);
        transfer::public_share_object(rider);
        transfer::public_share_object(soldier);


    }



    public entry fun confirm_capy_deck( general: CapyGeneral, monster: CapyMonster, rider: CapyRider, soldier: CapySoldier, ctx: &mut TxContext) {


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

        transfer::public_share_object(general);
        transfer::public_share_object(monster);
        transfer::public_share_object(rider);
        transfer::public_share_object(soldier);


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




    struct GameStatsEvent has copy, drop, store {
        
        
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



    public entry fun emit_game_stats_event(game: &Game) {
      
        event::emit( GameStatsEvent {
            player_one_address: game.player_one_address,
            player_two_address: game.player_two_address,
            coin_flip_guess: game.coin_flip_guess,
            coin_flip_count: game.coin_flip_count,
            coin_flip_result: game.coin_flip_result,
            even_turns: game.even_turns,
            odd_turns: game.odd_turns,
            turn_count: game.turn_count,
            confirm_deck_player_one: game.confirm_deck_player_one,
            confirm_deck_player_two: game.confirm_deck_player_two,
            player_one_general_status: game.player_one_general_status,
            player_one_monster_status: game.player_one_monster_status,
            player_one_rider_status: game.player_one_rider_status,
            player_one_soldier_status: game.player_one_soldier_status,
            player_two_general_status: game.player_two_general_status,
            player_two_monster_status: game.player_two_monster_status,
            player_two_rider_status: game.player_two_rider_status,
            player_two_soldier_status: game.player_two_soldier_status,
        });

    }





    // player with key has ability to make turn
    struct TurnKey has key, store {
        id: UID,
        game_id: ID,
    }


    struct Checked has copy, drop {
        value: bool,
    }



   

    // starts game by:
    // taking a coin flip guess and is correct sending it to the player one address
    // if guess is not correct the turn key goes to player two
    // the game object makes all permanents alive
    public entry fun start_game(coin_flip_guess: u8, r: &Random, player_one_address: address, player_two_address: address,  confirm_deck_player_one: &ConfirmedDeck, confirm_deck_player_two: &ConfirmedDeck, ctx: &mut TxContext)  {

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
                game_id: object::id(&game),
            };

            transfer::transfer(turn_key, player_one_address);
        } else {

            let turn_key = TurnKey {
                id: object::new(ctx),
                game_id: object::id(&game),
            };

            transfer::transfer(turn_key, player_two_address);

            game.even_turns = player_two_address;
            game.odd_turns = player_one_address;

        };



        transfer::public_share_object(game);



    }





    // turn trial no hash
    // entry fun turn_trial(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: Card, attacker_deck_confirmed: &ConfirmedDeck, defense_choice: u8, defender_deck_confirmed: &ConfirmedDeck,  possible_defense_general: Card, possible_defense_monster: Card, possible_defense_rider: Card, possible_defense_soldier: Card, ctx: &mut TxContext){


    //     // sets which player is using turn
    //     let player_on_deck: u8 = 0;

    //     if(game.player_one_address == tx_context::sender(ctx)){
    //         player_on_deck = 1;
    //     };

    //     if(game.player_two_address == tx_context::sender(ctx)){
    //         player_on_deck = 2;
    //     };





    //     // pass the turn key
    //     // check the player and pass to the opposite player
    //     if(player_on_deck == 1){
    //         transfer::public_transfer(turn_key, game.player_two_address);
    //     } else {
    //         transfer::public_transfer(turn_key, game.player_one_address);
    //     };




    //     // attack andd defend
    //     // attack_defend(r, game, attacker, attacker_deck_confirmed, defender_deck_confirmed, defense_choice, possible_defense_general, possible_defense_monster, possible_defense_rider, possible_defense_soldier, ctx);

     

    

    // }





    // turn actions and deletes the HashedSelectionProved object
    // UNDER CONSTRUCTION 
    // requires two owners break down the turn_trial function
    entry fun turn_trial_with_hash(turn_key: TurnKey, game: &mut Game, proven: HashedSelectionProved, ctx: &mut TxContext){


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };









        // pass the turn key
        // check the player and pass to the opposite player
        if(player_on_deck == 1){
            transfer::public_transfer(turn_key, game.player_two_address);
        } else {
            transfer::public_transfer(turn_key, game.player_one_address);
        };

       



        // checks the turn is correct by odd or even
        // if(game.even_turns == ctx && game.turn_count % 2 == 0) {
        //     // correct check
        // };


        

        // checks the hash is correct and proceeds or not
        if(proven.proved == true) {

            

            let HashedSelectionProved {id, proved: _} = proven;

            object::delete(id);


            // increment turn count
            game.turn_count = game.turn_count + 1;



            // do turn actions .. 

            event::emit( Checked {
                value: true,
            });


            
            
        } else {
            
            
            debug::print<bool>(&proven.proved);
            
            let HashedSelectionProved {id, proved: _} = proven;

            object::delete(id);


            // increment turn count
            game.turn_count = game.turn_count + 1;



            event::emit( Checked {
                value: false,
            })



            
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



    // --------------------------------------------------------------------------
    // --------------------------------------------------------------------------
    // ATTACK AND DEFEND FOR TURN STRUCTURE
    // --------------------------------------------------------------------------
    // --------------------------------------------------------------------------


    // takes random, game, attack card, attacker confirmed deck, defender confirmed
    // // uses the type_id to match and call the correct attack function
    // entry fun attack_generic(r: &Random, game: &mut Game, attacker: Card, attacker_deck_confirmed: &ConfirmedDeck, defender: Card, defender_deck_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {

    //     // ONES (General)
    //     if(attacker.type_id == 1 && defender.type_id == 1) {
    //         general_vs_general(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 1 && defender.type_id == 2) {
    //         general_vs_monster(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 1 && defender.type_id == 3) {
    //         general_vs_rider(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 1 && defender.type_id == 4) {
    //         general_vs_soldier(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 2 && defender.type_id == 1) {
    //         monster_vs_general(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 2 && defender.type_id == 2) {
    //         monster_vs_monster(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 2 && defender.type_id == 3) {
    //         monster_vs_rider(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 2 && defender.type_id == 4) {
    //         monster_vs_soldier(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 3 && defender.type_id == 1) {
    //         rider_vs_general(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 3 && defender.type_id == 2) {
    //         rider_vs_monster(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 3 && defender.type_id == 3) {
    //         rider_vs_rider(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 3 && defender.type_id == 4) {
    //         rider_vs_soldier(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 4 && defender.type_id == 1) {
    //         soldier_vs_general(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 4 && defender.type_id == 2) {
    //         soldier_vs_monster(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 4 && defender.type_id == 3) {
    //         soldier_vs_rider(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else if(attacker.type_id == 4 && defender.type_id == 4) {
    //         soldier_vs_soldier(r, attacker, attacker_deck_confirmed, defender, defender_deck_confirmed, ctx);
    //     } else {
    //         transfer::public_transfer(attacker, tx_context::sender(ctx));
    //         transfer::public_transfer(defender, tx_context::sender(ctx));
    //     };   

        

    // }


    struct DefenseCardAttacked has copy, drop {
        type_id: u8,
        name: String,
    }



    // choice 1 for backline and 2 for frontline stance
    entry fun defensive_posture(r: &Random, choice: u8, ctx: &mut TxContext ) : u8 {

        let card_selected: String = utf8(b"blank");
        let card_selected_type: u8 = 0;

        // defense return 1 general, 2 monster, 3 riser, 4 soldier
        // THIS CHOICE WILL COSET CP
        if( choice == 1){

            let card_selected_type = backline_defense_stance(r, ctx);

        // FREE OPTION
        } else  {

            let card_selected_type = frontline_defense_stance(r, ctx);

        };


        if( card_selected_type == 1 ){
            card_selected = utf8(b"general");
        } else if ( card_selected_type == 2 ) {
            card_selected = utf8(b"monster");
        } else if ( card_selected_type == 3 ) {
            card_selected = utf8(b"rider");
        } else if ( card_selected_type == 1 ) {
            card_selected = utf8(b"soldier");
        };


        event::emit( DefenseCardAttacked{
            type_id: card_selected_type,
            name: card_selected,
        });


        card_selected_type
        
        
    }
    


    // attacker needs to commit one card, defender all cards
    // modify to iinclude what to do in case of losing a card to take as parameter
    // create a 'DEAD' card to pass after losing a player that has no value
    // UNDER CONSTRUCTION

    // takes random, game, attack card, attacker confirmed deck, all defenders cards, defender confirmed AND
    // takes defense posture choice and all of the defenders cards


    // entry fun attack_defend(r: &Random, game: &mut Game, attacker: Card, attacker_deck_confirmed: &ConfirmedDeck, defender_deck_confirmed: &ConfirmedDeck, defense_choice: u8, possible_defense_general: Card, possible_defense_monster: Card, possible_defense_rider: Card, possible_defense_soldier: Card, ctx: &mut TxContext) {


    //     let defense_card = defensive_posture(r, defense_choice, ctx);

    //     let defender: Card;

    //     let attacker_address: address = attacker.owner_address;

    //     let defender_address: address = possible_defense_general.owner_address;


    //     // determines the attack functions used
    //     if (defense_card == 1 ) {

    //         attack_generic( r, game, attacker, attacker_deck_confirmed, possible_defense_general, defender_deck_confirmed, ctx);


    //         transfer::public_transfer(possible_defense_monster, defender_address);
    //         transfer::public_transfer(possible_defense_rider, defender_address);
    //         transfer::public_transfer(possible_defense_soldier, defender_address);

    //     } else if ( defense_card == 2 ) {

    //         attack_generic( r, game, attacker, attacker_deck_confirmed, possible_defense_monster, defender_deck_confirmed, ctx);


    //         transfer::public_transfer(possible_defense_general, defender_address);
    //         transfer::public_transfer(possible_defense_rider, defender_address);
    //         transfer::public_transfer(possible_defense_soldier, defender_address);

           
    //     } else if ( defense_card == 3 ) {
            
    //         attack_generic( r, game, attacker, attacker_deck_confirmed, possible_defense_rider, defender_deck_confirmed, ctx);


    //         transfer::public_transfer(possible_defense_general, defender_address);
    //         transfer::public_transfer(possible_defense_monster, defender_address);
    //         transfer::public_transfer(possible_defense_soldier, defender_address);

           
    //     } else if ( defense_card == 4 ) {

    //         attack_generic( r, game, attacker, attacker_deck_confirmed, possible_defense_soldier, defender_deck_confirmed, ctx);


    //         transfer::public_transfer(possible_defense_general, defender_address);
    //         transfer::public_transfer(possible_defense_monster, defender_address);
    //         transfer::public_transfer(possible_defense_rider, defender_address);


    //     } else {

    //         transfer::public_transfer(attacker, attacker_address);


    //         transfer::public_transfer(possible_defense_general, defender_address);
    //         transfer::public_transfer(possible_defense_monster, defender_address);
    //         transfer::public_transfer(possible_defense_rider, defender_address);
    //         transfer::public_transfer(possible_defense_soldier, defender_address);


    //     };


    // }



    
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
    // END OF GAME CHECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------

    struct Winner has copy, drop {
        player_one_winner: bool,
        player_two_winner: bool,
    }



    public entry fun game_over(game: &mut Game) {

        let player_one_wins: bool = false;
        let player_two_wins: bool = false;


        if(game.player_one_general_status == 0 && game.player_one_monster_status == 0 && game.player_one_rider_status == 0 && game.player_one_soldier_status == 0) {
            player_two_wins = true;

            event::emit( Winner {
                player_one_winner: false,
                player_two_winner: true,
            });

        };


        if(game.player_two_general_status == 0 && game.player_two_monster_status == 0 && game.player_two_rider_status == 0 && game.player_two_soldier_status == 0) {
            player_one_wins = true;

            event::emit( Winner {
                player_one_winner: true,
                player_two_winner: false,
            });

        };





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
    // MAKE PRICVATE!!!!!!!!
    // soldier vs soldier
    // entry fun gnome_soldier_vs_capy_soldier(r: &Random, soldier_attack: &mut GnomeSoldier, gnome_soldier_owner_cap: &GnomeSoldierOwnerCap, soldier_attack_confirmed: &ConfirmedDeck, soldier_defense: &mut CapySoldier, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = soldier_attack.owner_address;
    //     let address_defender = soldier_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(soldier_attack.type_id == 4, 99);
    //     assert!(soldier_defense.type_id == 4, 99);


    //     // checks cards are confirmed for gameplay
    //     // if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
    //     //     attack_card_confirmed = true;
    //     // };


    //     // if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
    //     //     defense_card_confirmed = true;
    //     // };


    //     // assert!(attack_card_confirmed == true, 99);
    //     // assert!(defense_card_confirmed == true, 99);




    //     // 50% probability of attack success
    //     if( fifty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         soldier_defense.health = soldier_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, emit death event
    //     if(soldier_defense.health == 0) {
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(soldier_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(soldier_attack, address_attacker);
        

        

    // }



    

    // ADD CP COSTS
    // // soldier vs rider
    // entry fun soldier_vs_rider(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = soldier_attack.owner_address;
    //     let address_defender = rider_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(soldier_attack.type_id == 4, 99);
    //     assert!(rider_defense.type_id == 3, 99);


    //     // checks cards are confirmed for gameplay
    //     if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 40% probability of attack success
    //     if( forty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         rider_defense.health = rider_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(rider_defense.health == 0) {
    //         delete_card(rider_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(rider_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(soldier_attack, address_attacker);
        

        

    // }




    // // ADD CP COSTS
    // // soldier vs monster
    // entry fun soldier_vs_monster(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = soldier_attack.owner_address;
    //     let address_defender = monster_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(soldier_attack.type_id == 4, 99);
    //     assert!(monster_defense.type_id == 2, 99);


    //     // checks cards are confirmed for gameplay
    //     if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 33% probability of attack success
    //     if( thirty_three_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         monster_defense.health = monster_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(monster_defense.health == 0) {
    //         delete_card(monster_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(monster_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(soldier_attack, address_attacker);
        

        

    // }






    // // ADD CP COSTS
    // // soldier vs general
    // entry fun soldier_vs_general(r: &Random, soldier_attack: Card, soldier_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = soldier_attack.owner_address;
    //     let address_defender = general_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(soldier_attack.type_id == 4, 99);
    //     assert!(general_defense.type_id == 1, 99);


    //     // checks cards are confirmed for gameplay
    //     if(soldier_attack_confirmed.soldier_id == object::id(&soldier_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(general_defense_confirmed.general_id == object::id(&general_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 66% probability of attack success
    //     if( sixty_six_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         general_defense.health = general_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(general_defense.health == 0) {
    //         delete_card(general_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(general_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(soldier_attack, address_attacker);
        

        

    // }





    








    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // RIDER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // // rider vs soldier
    // entry fun rider_vs_soldier(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = rider_attack.owner_address;
    //     let address_defender = soldier_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(rider_attack.type_id == 3, 99);
    //     assert!(soldier_defense.type_id == 4, 99);


    //     // checks cards are confirmed for gameplay
    //     if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 60% probability of attack success
    //     if( sixty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         soldier_defense.health = soldier_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(soldier_defense.health == 0) {
    //         delete_card(soldier_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(soldier_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(rider_attack, address_attacker);
        

        

    // }



    

    // // ADD CP COSTS
    // // rider vs rider
    // entry fun rider_vs_rider(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = rider_attack.owner_address;
    //     let address_defender = rider_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(rider_attack.type_id == 3, 99);
    //     assert!(rider_defense.type_id == 3, 99);


    //     // checks cards are confirmed for gameplay
    //     if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 50% probability of attack success
    //     if( fifty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         rider_defense.health = rider_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(rider_defense.health == 0) {
    //         delete_card(rider_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(rider_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(rider_attack, address_attacker);
        

        

    // }




    // // ADD CP COSTS
    // // rider vs monster
    // entry fun rider_vs_monster(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = rider_attack.owner_address;
    //     let address_defender = monster_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(rider_attack.type_id == 3, 99);
    //     assert!(monster_defense.type_id == 2, 99);


    //     // checks cards are confirmed for gameplay
    //     if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 40% probability of attack success
    //     if( forty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         monster_defense.health = monster_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(monster_defense.health == 0) {
    //         delete_card(monster_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(monster_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(rider_attack, address_attacker);
        

        

    // }






    // // ADD CP COSTS
    // // rider vs general
    // entry fun rider_vs_general(r: &Random, rider_attack: Card, rider_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = rider_attack.owner_address;
    //     let address_defender = general_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(rider_attack.type_id == 3, 99);
    //     assert!(general_defense.type_id == 1, 99);


    //     // checks cards are confirmed for gameplay
    //     if(rider_attack_confirmed.rider_id == object::id(&rider_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(general_defense_confirmed.general_id == object::id(&general_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 75% probability of attack success
    //     if( seventy_five_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         general_defense.health = general_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(general_defense.health == 0) {
    //         delete_card(general_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(general_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(rider_attack, address_attacker);
        

        

    // }











    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // MONSTER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // monster vs soldier
    // entry fun monster_vs_soldier(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = monster_attack.owner_address;
    //     let address_defender = soldier_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(monster_attack.type_id == 2, 99);
    //     assert!(soldier_defense.type_id == 4, 99);


    //     // checks cards are confirmed for gameplay
    //     if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 60% probability of attack success
    //     if( sixty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         soldier_defense.health = soldier_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(soldier_defense.health == 0) {
    //         delete_card(soldier_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(soldier_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(monster_attack, address_attacker);
        

        

    // }



    

    // // ADD CP COSTS
    // // monster vs rider
    // entry fun monster_vs_rider(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = monster_attack.owner_address;
    //     let address_defender = rider_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(monster_attack.type_id == 2, 99);
    //     assert!(rider_defense.type_id == 3, 99);


    //     // checks cards are confirmed for gameplay
    //     if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 55% probability of attack success
    //     if( fifty_five_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         rider_defense.health = rider_defense.health - 1;
    //     event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(rider_defense.health == 0) {
    //         delete_card(rider_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(rider_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(monster_attack, address_attacker);
        

        

    // }




    // // ADD CP COSTS
    // // monster vs monster
    // entry fun monster_vs_monster(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = monster_attack.owner_address;
    //     let address_defender = monster_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(monster_attack.type_id == 2, 99);
    //     assert!(monster_defense.type_id == 2, 99);


    //     // checks cards are confirmed for gameplay
    //     if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 50% probability of attack success
    //     if( fifty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         monster_defense.health = monster_defense.health - 1;
    //     event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(monster_defense.health == 0) {
    //         delete_card(monster_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(monster_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(monster_attack, address_attacker);
        

        

    // }






    // // ADD CP COSTS
    // // monster vs general
    // entry fun monster_vs_general(r: &Random, monster_attack: Card, monster_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = monster_attack.owner_address;
    //     let address_defender = general_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(monster_attack.type_id == 2, 99);
    //     assert!(general_defense.type_id == 1, 99);


    //     // checks cards are confirmed for gameplay
    //     if(monster_attack_confirmed.monster_id == object::id(&monster_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(general_defense_confirmed.general_id == object::id(&general_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 80% probability of attack success
    //     if( eighty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         general_defense.health = general_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(general_defense.health == 0) {
    //         delete_card(general_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(general_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(monster_attack, address_attacker);
        

        

    // }







    
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GENERAL ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // // general vs soldier
    // entry fun general_vs_soldier(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, soldier_defense: Card, soldier_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = general_attack.owner_address;
    //     let address_defender = soldier_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(general_attack.type_id == 1, 99);
    //     assert!(soldier_defense.type_id == 4, 99);


    //     // checks cards are confirmed for gameplay
    //     if(general_attack_confirmed.general_id == object::id(&general_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(soldier_defense_confirmed.soldier_id == object::id(&soldier_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 70% probability of attack success
    //     if( seventy_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         soldier_defense.health = soldier_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(soldier_defense.health == 0) {
    //         delete_card(soldier_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(soldier_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(general_attack, address_attacker);
        

        

    // }



    

    // // ADD CP COSTS
    // // general vs rider
    // entry fun general_vs_rider(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, rider_defense: Card, rider_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = general_attack.owner_address;
    //     let address_defender = rider_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(general_attack.type_id == 1, 99);
    //     assert!(rider_defense.type_id == 3, 99);


    //     // checks cards are confirmed for gameplay
    //     if(general_attack_confirmed.general_id == object::id(&general_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(rider_defense_confirmed.rider_id == object::id(&rider_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 60% probability of attack success
    //     if( sixty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         rider_defense.health = rider_defense.health - 1;
    //         event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(rider_defense.health == 0) {
    //         delete_card(rider_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(rider_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(general_attack, address_attacker);
        

        

    // }




    // // ADD CP COSTS
    // // general vs monster
    // entry fun general_vs_monster(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, monster_defense: Card, monster_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = general_attack.owner_address;
    //     let address_defender = monster_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(general_attack.type_id == 1, 99);
    //     assert!(monster_defense.type_id == 2, 99);


    //     // checks cards are confirmed for gameplay
    //     if(general_attack_confirmed.general_id == object::id(&general_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(monster_defense_confirmed.monster_id == object::id(&monster_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 556% probability of attack success
    //     if( fifty_five_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         monster_defense.health = monster_defense.health - 1;
    //     event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(monster_defense.health == 0) {
    //         delete_card(monster_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(monster_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(general_attack, address_attacker);
        

        

    // }






    // ADD CP COSTS
    // // general vs general
    // entry fun general_vs_general(r: &Random, general_attack: Card, general_attack_confirmed: &ConfirmedDeck, general_defense: Card, general_defense_confirmed: &ConfirmedDeck, ctx: &mut TxContext) {


    //     // vars
    //     let successful = false; 
    //     let address_attacker = general_attack.owner_address;
    //     let address_defender = general_defense.owner_address;
    //     let attack_card_confirmed = false;
    //     let defense_card_confirmed = false;
        
        
    //     // checks cards are correct type
    //     assert!(general_attack.type_id == 1, 99);
    //     assert!(general_defense.type_id == 1, 99);


    //     // checks cards are confirmed for gameplay
    //     if(general_attack_confirmed.general_id == object::id(&general_attack)){
    //         attack_card_confirmed = true;
    //     };


    //     if(general_defense_confirmed.general_id == object::id(&general_defense)){
    //         defense_card_confirmed = true;
    //     };


    //     assert!(attack_card_confirmed == true, 99);
    //     assert!(defense_card_confirmed == true, 99);




    //     // 80% probability of attack success
    //     if( eighty_percent_probability(r, ctx) == 1) {
    //         successful = true;
    //     };


    //     // if successful, decrease health of defense card by 1
    //     if(successful == true) {
    //         general_defense.health = general_defense.health - 1;
    //     event::emit(AttackSuccess {
    //             attack_success: true,
    //         });
    //     } else {
    //         event::emit(AttackFail {
    //             attack_success: false,
    //         });
    //     };



    //     // if defense card health is 0, delete card
    //     if(general_defense.health == 0) {
    //         delete_card(general_defense);
    //         event::emit(Death {
    //             death: true,
    //         });
    //     }  else {

    //         // public transfer defense card back to player
    //         transfer::public_transfer(general_defense, address_defender);

    //     };
        



    //     // public transfer attack card back to player
    //     transfer::public_transfer(general_attack, address_attacker);
        

        

    // }





























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




