
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
    use sui::coin::{Self, TreasuryCap, Coin};
    use sui::sui::SUI;
    use sui::balance::{Self, Balance};
    use sui::random::{Self, Random, new_generator};

 

    // closed-loop token
    use capy_vs_gnome::pleco::{PLECO, first_turns_mint};

    // used for random number generation 
    use capy_vs_gnome::random_funcs::{arithmetic_is_less_than}; 


    










    // CONTENTS:
    // PERMENANTS CARDS
    // GNOME CARDS 
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
    // CAPYBARA CARDS
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
    // PERMENANT CARD GETTERS 
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
    // CONFIRM DECKS AND CARDS
    //   - confirm_gnome_deck
    //   - confirm_gnome_soldier
    //   - confirm_gnome_rider
    //   - confirm_gnome_monster
    //   - confirm_gnome_general
    //   - confirm_capy_deck
    //   - confirm_capy_soldier
    //   - confirm_capy_rider
    //   - confirm_capy_monster
    //   - confirm_capy_general
    // GAME SETUP
    //    - Game
    //    - GameStatsEvent
    //    - emit_game_stats_event
    //    - TurnKey
    //    - start_game
    // TURN KEY PASS AND TURN CHECKS
    //    - pass_turn_key
    //    - player_one_or_two
    // ATTACK TURN CHECKS
    //    - attack_check_soldier
    //    - attack_check_rider
    //    - attack_check_monster
    //    - attack_check_general
    // DEFENSE TURN CHECKS
    //    - defense_check_soldier
    //    - defense_check_rider
    //    - defense_check_monster
    //    - defense_check_general
    // GNOME TURNS
    //    - turn_gnome_soldier
    //    - turn_gnome_rider
    //    - turn_gnome_monster
    //    - turn_gnome_general
    //    - turn_capy_soldier
    // CAPY TURNS
    //    - turn_capy_rider
    //    - turn_capy_monster
    //    - turn_capy_general
    //    - turn_trial_with_hash 
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
    //    - winner
    //    - player_one_general_confirmed
    //    - player_one_monster_confirmed
    //    - player_one_rider_confirmed
    //    - player_one_soldier_confirmed
    //    - player_two_general_confirmed
    //    - player_two_monster_confirmed
    //    - player_two_rider_confirmed
    //    - player_two_soldier_confirmed
    // END OF GAME CHECKS
    //    - Winner
    //    - check_for_winner
    // BET FUNCTIONS
    //     - EscrowForBets
    // GNOME ATTACK FUNCTIONS
    //   - gnome_soldier_vs_capy_soldier 
    //   - gnome_soldier_vs_capy_rider
    //   - gnome_soldier_vs_capy_monster
    //   - gnome_soldier_vs_capy_general
    //   - gnome_rider_vs_capy_soldier 
    //   - gnome_rider_vs_capy_rider
    //   - gnome_rider_vs_capy_monster
    //   - gnome_rider_vs_capy_general
    //   - gnome_monster_vs_capy_soldier 
    //   - gnome_monster_vs_capy_rider
    //   - gnome_monster_vs_capy_monster
    //   - gnome_monster_vs_capy_general
    //   - gnome_general_vs_capy_soldier 
    //   - gnome_general_vs_capy_rider
    //   - gnome_general_vs_capy_monster
    //   - gnome_general_vs_capy_general
    // CAPY ATTACK FUNCTIONS
    //   - capy_soldier_vs_gnome_soldier 
    //   - capy_soldier_vs_gnome_rider
    //   - capy_soldier_vs_gnome_monster
    //   - capy_soldier_vs_gnome_general
    //   - capy_rider_vs_gnome_soldier 
    //   - capy_rider_vs_gnome_rider
    //   - capy_rider_vs_gnome_monster
    //   - capy_rider_vs_gnome_general
    //   - capy_monster_vs_gnome_soldier 
    //   - capy_monster_vs_gnome_rider
    //   - capy_monster_vs_gnome_monster
    //   - capy_monster_vs_gnome_general
    //   - capy_general_vs_gnome_soldier 
    //   - capy_general_vs_gnome_rider
    //   - capy_general_vs_gnome_monster
    //   - capy_general_vs_gnome_general
    // DEFENSE FUNCTIONS
    //   - frontline_defense_stance
    //   - backline_defense_stance
    // DEFENSIVE POSTURE
    //    - DefenseCardAttacked
    //    - defensive_posture
    // COIN TOSS FUNCTIONS
    //   - coin_toss
    // PROBABILITY FUNCTIONS
    //   - twenty_five_percent_probability
    //   - thirty_three_percent_probability
    //   - forty_percent_probability
    //   - fifty_percent_probability
    //   - fifty_five_percent_probability
    //   - sixty_percent_probability
    //   - sixty_six_percent_probability
    //   - seventy_percent_probability
    //   - seventy_five_percent_probabilitygnome_monster_vs_capy_soldier
    //   - eighty_percent_probability
    // TIME FUNCTIONS
    //   - get_time
    // TEST INIT
    //   - init_for_testing
    //











    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // PERMENANTS CARDS 
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    // type_id: 1 = general, 2 = monster, 3 = rider, 4 = soldier

   
    
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
            health: 1,
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
            health: 1,
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
            health: 1,
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
            health: 1,
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
            health: 1,
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
            health: 1,
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
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        // ability_one: String,
    }



    fun mint_gnome_soldier(ctx: &mut TxContext) : GnomeSoldierOwnerCap {
       
        let id = object::new(ctx);

        let gnome_soldier = GnomeSoldier {
            id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome soldier"),
            type_id: 4,
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"QmXkTwHYLSbuVCErb1rXsnG3dcXwdzBU9fE6WNtFjx4fLG"),
            attack: 4,
            defense: 4,
            health: 1,
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

        let id = object::new(ctx);
        
        let gnome_soldier = GnomeSoldier {
            id,
            owner_address: tx_context::sender(ctx),
            type: utf8(b"gnome soldier"),
            type_id: 4,
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"QmXkTwHYLSbuVCErb1rXsnG3dcXwdzBU9fE6WNtFjx4fLG"),
            attack: 4,
            defense: 4,
            health: 1,
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
            health: 1,
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
            health: 1,
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
            health: 1,
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
            health: 1,
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
            health:1,
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
            health: 1,
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
            health: 1,
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
        let display_gnome_general = display::new_with_fields<GnomeGeneral>(
            &publisher, gnome_general_keys, gnome_general_values, ctx
        );

        display::update_version(&mut display_gnome_general);


        // add gnome monster
        let display_gnome_monster = display::new_with_fields<GnomeMonster>(
            &publisher, gnome_monster_keys, gnome_monster_values, ctx
        );

        display::update_version(&mut display_gnome_monster);


        // add gnome rider
        let display_gnome_rider = display::new_with_fields<GnomeRider>(
            &publisher, gnome_rider_keys, gnome_rider_values, ctx
        );

        display::update_version(&mut display_gnome_rider);


        // add gnome soldier
        let display_gnome_soldier = display::new_with_fields<GnomeSoldier>(
            &publisher, gnome_soldier_keys, gnome_soldier_values, ctx
        );

        display::update_version(&mut display_gnome_soldier);




        // add capybaras to display
        // add capy general
        let display_capy_general = display::new_with_fields<CapyGeneral>(
            &publisher, capy_general_keys, capy_general_values, ctx
        );

        display::update_version(&mut display_capy_general);


        // add capy monster
        let display_capy_monster = display::new_with_fields<CapyMonster>(
            &publisher, capy_monster_keys, capy_monster_values, ctx
        );

        display::update_version(&mut display_capy_monster);


        // add capy rider
        let display_capy_rider = display::new_with_fields<CapyRider>(
            &publisher, capy_rider_keys, capy_rider_values, ctx
        );

        display::update_version(&mut display_capy_rider);


        // add capy soldier
        let display_capy_soldier = display::new_with_fields<CapySoldier>(
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


   

    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CONFIRM GNOME DECK AND CARDS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    public entry fun confirm_gnome_deck(

        general: &GnomeGeneral, 
        general_owner_cap: &GnomeGeneralOwnerCap, 
        monster: &GnomeMonster, 
        gnome_monster_owner_cap: &GnomeMonsterOwnerCap, 
        rider: &GnomeRider, 
        gnome_rider_owner_cap: &GnomeRiderOwnerCap, 
        soldier: &GnomeSoldier, 
        gnome_soldier_owner_cap: &GnomeSoldierOwnerCap, 
        ctx: &mut TxContext

    ) {

        let attack = false;
        let defense = false;
        let health = false;
        let cost = false;



        // check conditions
        if (general.attack == 10 || monster.attack == 8 || rider.attack == 6 || soldier.attack == 4) {
            attack = true;
        };

        if (general.defense == 2 || monster.defense == 8 || rider.defense == 6 || soldier.defense == 4) {
            defense = true;
        };

        if (general.health == 1 || monster.health == 1 || rider.health == 1 || soldier.health == 1) {
            health = true;
        };

        if (general.cost == 6 || monster.cost == 5 || rider.cost == 4 || soldier.cost == 2) {
            cost = true;
        };


        if (attack == true || defense == true || health == true || cost == true) {

            let confirmed_deck = ConfirmedDeck {
                
            id: object::new(ctx),
            general_id: *object::borrow_id<GnomeGeneral>(general),
            monster_id: *object::borrow_id<GnomeMonster>(monster),
            rider_id: *object::borrow_id<GnomeRider>(rider),
            soldier_id: *object::borrow_id<GnomeSoldier>(soldier),

            };  


        // share the confirmed_deck object after all checks are done
        transfer::public_share_object(confirmed_deck);

        };


        

    }







    struct CardConfirmed has copy, store, drop {

        card_confirmed: bool,

    }






    // markes in the game object the card is confirmed for gameplay, ,if a caard is not confirmed gameplay cannot continue
    entry fun confirm_gnome_soldier(card: &GnomeSoldier, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.soldier_id == *object::borrow_id<GnomeSoldier>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_soldier_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_soldier_confirmed = true;

            };
            

        };


    }




    entry fun confirm_gnome_rider(card: &GnomeRider, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.rider_id == *object::borrow_id<GnomeRider>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_rider_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_rider_confirmed = true;

            };
            

        };


    }



    entry fun confirm_gnome_monster(card: &GnomeMonster, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.monster_id == *object::borrow_id<GnomeMonster>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_monster_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_monster_confirmed = true;

            };
            

        };


    }



    entry fun confirm_gnome_general(card: &GnomeGeneral, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.general_id == *object::borrow_id<GnomeGeneral>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_general_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_general_confirmed = true;

            };
            

        };


    }














    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CONFIRM CAPY DECK AND CARDS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------




    public entry fun confirm_capy_deck(

        general: &CapyGeneral, 
        general_owner_cap: &CapyGeneralOwnerCap, 
        monster: &CapyMonster, 
        gnome_monster_owner_cap: &CapyMonsterOwnerCap, 
        rider: &CapyRider, 
        gnome_rider_owner_cap: &CapyRiderOwnerCap, 
        soldier: &CapySoldier, 
        gnome_soldier_owner_cap: &CapySoldierOwnerCap, 
        ctx: &mut TxContext
    ) {

        let attack = false;
        let defense = false;
        let health = false;
        let cost = false;



        // check conditions
        if (general.attack == 10 || monster.attack == 8 || rider.attack == 6 || soldier.attack == 4) {
            attack = true;
        };

        if (general.defense == 2 || monster.defense == 8 || rider.defense == 6 || soldier.defense == 4) {
            defense = true;
        };

        if (general.health == 1 || monster.health == 1 || rider.health == 1 || soldier.health == 1) {
            health = true;
        };

        if (general.cost == 6 || monster.cost == 5 || rider.cost == 4 || soldier.cost == 2) {
            cost = true;
        };


        if (attack == true || defense == true || health == true || cost == true) {

            let confirmed_deck = ConfirmedDeck {
                
            id: object::new(ctx),
            general_id: *object::borrow_id<CapyGeneral>(general),
            monster_id: *object::borrow_id<CapyMonster>(monster),
            rider_id: *object::borrow_id<CapyRider>(rider),
            soldier_id: *object::borrow_id<CapySoldier>(soldier),

            };  


        // share the confirmed_deck object after all checks are done
        transfer::public_share_object(confirmed_deck);

        };


        

    }







    // markes in the game object the card is confirmed for gameplay, ,if a caard is not confirmed gameplay cannot continue
    entry fun confirm_capy_soldier(card: &CapySoldier, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.soldier_id == *object::borrow_id<CapySoldier>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_soldier_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_soldier_confirmed = true;

            };
            

        };

        

    }




    entry fun confirm_capy_rider(card: &CapyRider, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.rider_id == *object::borrow_id<CapyRider>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_rider_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_rider_confirmed = true;

            };
            

        };


    }



    entry fun confirm_capy_monster(card: &CapyMonster, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.monster_id == *object::borrow_id<CapyMonster>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_monster_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_monster_confirmed = true;

            };
            

        };


    }



    entry fun confirm_capy_general(card: &CapyGeneral, confirmed_deck: &ConfirmedDeck, game: &mut Game, ctx: &mut TxContext) {

        let card_confirmed = false;


        // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        // checks cards are confirmed for gameplay
        if(confirmed_deck.general_id == *object::borrow_id<CapyGeneral>(card)){
            
            card_confirmed = true;

            event::emit( CardConfirmed {
                card_confirmed,
            });


            if(player_on_deck == 1) {

                game.player_one_general_confirmed = true;

            } else if (player_on_deck == 2) {

                game.player_two_general_confirmed = true;

            };
            

        };


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
        winner: bool,
        player_one_general_confirmed: bool,
        player_one_monster_confirmed: bool,
        player_one_rider_confirmed: bool,
        player_one_soldier_confirmed: bool,
        player_two_general_confirmed: bool,
        player_two_monster_confirmed: bool,
        player_two_rider_confirmed: bool,
        player_two_soldier_confirmed: bool,


       
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
        winner: bool,
        player_one_general_confirmed: bool,
        player_one_monster_confirmed: bool,
        player_one_rider_confirmed: bool,
        player_one_soldier_confirmed: bool,
        player_two_general_confirmed: bool,
        player_two_monster_confirmed: bool,
        player_two_rider_confirmed: bool,
        player_two_soldier_confirmed: bool,
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
            winner: false,
            player_one_general_confirmed: game.player_one_general_confirmed,
            player_one_monster_confirmed: game.player_one_monster_confirmed,
            player_one_rider_confirmed: game.player_one_rider_confirmed,
            player_one_soldier_confirmed: game.player_one_soldier_confirmed,
            player_two_general_confirmed: game.player_two_general_confirmed,
            player_two_monster_confirmed: game.player_two_monster_confirmed,
            player_two_rider_confirmed: game.player_two_rider_confirmed,
            player_two_soldier_confirmed: game.player_two_soldier_confirmed,
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

            winner: false,

            // confirmation status
            player_one_general_confirmed: false,
            player_one_monster_confirmed: false,
            player_one_rider_confirmed: false,
            player_one_soldier_confirmed: false,
            player_two_general_confirmed: false,
            player_two_monster_confirmed: false,
            player_two_rider_confirmed: false,
            player_two_soldier_confirmed: false,
           
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




    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // TURN KEY PASS AND TURN CHECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------




    entry fun pass_turn_key(turn_key: TurnKey, game: &mut Game, ctx: &mut TxContext){
        


        // sets which player is using turn
        let player_on_deck = player_one_or_two(game, ctx);


        // pass the turn key
        // check the player and pass to the opposite player
        if(player_on_deck == 1){
            transfer::public_transfer(turn_key, game.player_two_address);
        } else {
            transfer::public_transfer(turn_key, game.player_one_address);
        };


    }



    entry fun player_one_or_two(game: &Game, ctx: &mut TxContext) : u8 {
        

         // sets which player is using turn
        let player_on_deck: u8 = 0;

        if(game.player_one_address == tx_context::sender(ctx)){
            player_on_deck = 1;
        };

        if(game.player_two_address == tx_context::sender(ctx)){
            player_on_deck = 2;
        };


        player_on_deck


    }


    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // ATTACK TURN CHECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------



    fun attack_check_soldier(player_on_deck: u8, game: &mut Game){

        if ((player_on_deck == 1) && (game.player_one_soldier_status == 0)) {   
                abort(1)
        };


        if ((player_on_deck == 2) && (game.player_two_soldier_status == 0)) {   
                abort(1)
        };
    }


    fun attack_check_rider(player_on_deck: u8, game: &mut Game){

        if ((player_on_deck == 1) && (game.player_one_rider_status == 0)) {   
                abort(1)
        };


        if ((player_on_deck == 2) && (game.player_two_rider_status == 0)) {   
                abort(1)
        };
    }


    fun attack_check_monster(player_on_deck: u8, game: &mut Game){

        if ((player_on_deck == 1) && (game.player_one_monster_status == 0)) {   
                abort(1)
        };


        if ((player_on_deck == 2) && (game.player_two_monster_status == 0)) {   
                abort(1)
        };
    }


    fun attack_check_general(player_on_deck: u8, game: &mut Game){

        if ((player_on_deck == 1) && (game.player_one_general_status == 0)) {   
                abort(1)
        };


        if ((player_on_deck == 2) && (game.player_two_general_status == 0)) {   
                abort(1)
        };
    }



    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // DEFENSE TURN CHECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    fun defense_check_soldier(player_on_deck: u8, game: &mut Game ){

        if ((player_on_deck == 1) && (game.player_two_soldier_status == 0)) {
            
                abort(1)
            
        };


        if ((player_on_deck == 2) && (game.player_one_soldier_status == 0)) {
        
            
            abort(1)
        
        };

    }



    fun defense_check_rider(player_on_deck: u8, game: &mut Game ){

        if ((player_on_deck == 1) && (game.player_two_rider_status == 0)) {
            
                abort(1)
            
        };


        if ((player_on_deck == 2) && (game.player_one_rider_status == 0)) {
        
            
            abort(1)
        
        };
        

    }



    fun defense_check_monster(player_on_deck: u8, game: &mut Game ){

        if ((player_on_deck == 1) && (game.player_two_monster_status == 0)) {
            
                abort(1)
            
            };


        if ((player_on_deck == 2) && (game.player_one_monster_status == 0)) {
        
            
            abort(1)
        
        };

    }




    fun defense_check_general(player_on_deck: u8, game: &mut Game ){

        if ((player_on_deck == 1) && (game.player_two_general_status == 0)) {
            
                abort(1)
            
            };


        if ((player_on_deck == 2) && (game.player_one_general_status == 0)) {
        
            
            abort(1)
        
        };

    }



    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // GNOME TURNS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------

    // CHECK ATACK AND DEFENSE IN PLAY

    // turn trial no hash
    entry fun turn_gnome_soldier(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut GnomeSoldier, attacker_owner_cap: &GnomeSoldierOwnerCap, defense_choice: u8,  possible_defense_general: &mut CapyGeneral, possible_defense_monster: &mut CapyMonster, possible_defense_rider: &mut CapyRider, possible_defense_soldier: &mut CapySoldier, ctx: &mut TxContext){


        pass_turn_key(turn_key, game, ctx);

        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_soldier(player_on_deck, game);
        


        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        



        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {

            defense_check_general(player_on_deck, game);

            // checks for winner
            gnome_soldier_vs_capy_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);

            game.turn_count = game.turn_count + 1;


        };



        
        if ( defense_card == 2 ) {


            defense_check_monster(player_on_deck, game);
            

            gnome_soldier_vs_capy_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);


            game.turn_count = game.turn_count + 1;


        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            gnome_soldier_vs_capy_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);


            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            gnome_soldier_vs_capy_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);


            game.turn_count = game.turn_count + 1;

        };



     

    }




    entry fun turn_gnome_rider(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut GnomeRider, attacker_owner_cap: &GnomeRiderOwnerCap, defense_choice: u8,  possible_defense_general: &mut CapyGeneral, possible_defense_monster: &mut CapyMonster, possible_defense_rider: &mut CapyRider, possible_defense_soldier: &mut CapySoldier, ctx: &mut TxContext){

        pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_rider(player_on_deck, game);




        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {

            defense_check_general(player_on_deck, game);
            
            // checks for winner
            gnome_rider_vs_capy_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);


            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            gnome_rider_vs_capy_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);


            game.turn_count = game.turn_count + 1;

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            gnome_rider_vs_capy_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);


            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            gnome_rider_vs_capy_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);


            game.turn_count = game.turn_count + 1;

        };



     

    }



    entry fun turn_gnome_monster(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut GnomeMonster, attacker_owner_cap: &GnomeMonsterOwnerCap, defense_choice: u8,  possible_defense_general: &mut CapyGeneral, possible_defense_monster: &mut CapyMonster, possible_defense_rider: &mut CapyRider, possible_defense_soldier: &mut CapySoldier, ctx: &mut TxContext){

        pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };

        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);

        attack_check_monster(player_on_deck, game);



        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {

            defense_check_general(player_on_deck, game);
            
            // checks for winner
            gnome_monster_vs_capy_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);


            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            gnome_monster_vs_capy_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            gnome_monster_vs_capy_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            gnome_monster_vs_capy_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);


            game.turn_count = game.turn_count + 1;

        };



     

    }




    entry fun turn_gnome_general(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut GnomeGeneral, attacker_owner_cap: &GnomeGeneralOwnerCap, defense_choice: u8,  possible_defense_general: &mut CapyGeneral, possible_defense_monster: &mut CapyMonster, possible_defense_rider: &mut CapyRider, possible_defense_soldier: &mut CapySoldier, ctx: &mut TxContext){

        pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_general(player_on_deck, game);



        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {
            

            defense_check_general(player_on_deck, game); 

            // checks for winner
            gnome_general_vs_capy_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            gnome_general_vs_capy_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);

            game.turn_count = game.turn_count + 1;

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            gnome_general_vs_capy_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {


            defense_check_soldier(player_on_deck, game);

            gnome_general_vs_capy_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);

            game.turn_count = game.turn_count + 1;

        };



     

    }





    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // CAPY TURNS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------



    // turn trial no hash
    entry fun turn_capy_soldier(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut CapySoldier, attacker_owner_cap: &CapySoldierOwnerCap, defense_choice: u8,  possible_defense_general: &mut GnomeGeneral, possible_defense_monster: &mut GnomeMonster, possible_defense_rider: &mut GnomeRider, possible_defense_soldier: &mut GnomeSoldier, ctx: &mut TxContext){



        pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_soldier(player_on_deck, game);



        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {
            

            defense_check_general(player_on_deck, game);

            // checks for winner
            capy_soldier_vs_gnome_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);


            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            capy_soldier_vs_gnome_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);

            game.turn_count = game.turn_count + 1;

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            capy_soldier_vs_gnome_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            capy_soldier_vs_gnome_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);

            game.turn_count = game.turn_count + 1;

        };



     

    }




    entry fun turn_capy_rider(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut CapyRider, attacker_owner_cap: &CapyRiderOwnerCap, defense_choice: u8,  possible_defense_general: &mut GnomeGeneral, possible_defense_monster: &mut GnomeMonster, possible_defense_rider: &mut GnomeRider, possible_defense_soldier: &mut GnomeSoldier, ctx: &mut TxContext){



       pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_rider(player_on_deck, game);



        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {

            defense_check_general(player_on_deck, game);
            
            // checks for winner
            capy_rider_vs_gnome_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            capy_rider_vs_gnome_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);

            game.turn_count = game.turn_count + 1;

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            capy_rider_vs_gnome_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            capy_rider_vs_gnome_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);


            game.turn_count = game.turn_count + 1;

        };



     

    }



    entry fun turn_capy_monster(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut CapyMonster, attacker_owner_cap: &CapyMonsterOwnerCap, defense_choice: u8,  possible_defense_general: &mut GnomeGeneral, possible_defense_monster: &mut GnomeMonster, possible_defense_rider: &mut GnomeRider, possible_defense_soldier: &mut GnomeSoldier, ctx: &mut TxContext){



        pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_monster(player_on_deck, game);



        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {

            defense_check_general(player_on_deck, game);
            
            // checks for winner
            capy_monster_vs_gnome_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            capy_monster_vs_gnome_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);

            game.turn_count = game.turn_count + 1;

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            capy_monster_vs_gnome_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            capy_monster_vs_gnome_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);

            game.turn_count = game.turn_count + 1;

        };



     

    }




    entry fun turn_capy_general(r: &Random, turn_key: TurnKey, game: &mut Game, attacker: &mut CapyGeneral, attacker_owner_cap: &CapyGeneralOwnerCap, defense_choice: u8,  possible_defense_general: &mut GnomeGeneral, possible_defense_monster: &mut GnomeMonster, possible_defense_rider: &mut GnomeRider, possible_defense_soldier: &mut GnomeSoldier, ctx: &mut TxContext){



        pass_turn_key(turn_key, game, ctx);

        // checks if the game is closed and a winner is declared
        if(game.winner == true){
            abort(1)
        };


        // checks the attack card is in play
        let player_on_deck = player_one_or_two(game, ctx);


        attack_check_general(player_on_deck, game);


        // returns 1 for genreal, 2 for monster, 3 for rider, and 4 for soldier
        let defense_card = defensive_posture(r, defense_choice, ctx);




        // determines the attack functions used based on the defense card and chewcks for winner
        if (defense_card == 1 ) {

            defense_check_general(player_on_deck, game);
            
            // checks for winner
            capy_general_vs_gnome_general(r, game, attacker, attacker_owner_cap, possible_defense_general, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        if ( defense_card == 2 ) {

            defense_check_monster(player_on_deck, game);

            capy_general_vs_gnome_monster( r, game, attacker, attacker_owner_cap, possible_defense_monster, ctx);

            game.turn_count = game.turn_count + 1;

        }; 
        
        if ( defense_card == 3 ) {

            defense_check_rider(player_on_deck, game);
            
            capy_general_vs_gnome_rider(r, game, attacker, attacker_owner_cap, possible_defense_rider, ctx);

            game.turn_count = game.turn_count + 1;


        };
        
        
        if ( defense_card == 4 ) {

            defense_check_soldier(player_on_deck, game);

            capy_general_vs_gnome_soldier( r, game, attacker, attacker_owner_cap, possible_defense_soldier, ctx);

            game.turn_count = game.turn_count + 1;

        };



     

    }
















    
    // UNDER CONSTRUCTION 
    // first decision cant be changed after defense makes choice
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
    public fun first_turn( cap: &mut TreasuryCap<PLECO>, recipient: address, ctx: &mut TxContext) {

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



    // player two soldier status
    public fun winner(game: &Game) : bool {

        let winner = game.winner;

        winner
    }


    // player one general status
    public fun player_one_general_confirmed(game: &Game) : bool {

        let player_one_general_confirmed = game.player_one_general_confirmed;

        player_one_general_confirmed
    }


    // player one monster status
    public fun player_one_monster_confirmed(game: &Game) : bool {

        let player_one_monster_confirmed = game.player_one_monster_confirmed;

        player_one_monster_confirmed
    }


    // player one  rider status
    public fun player_one_rider_confirmed(game: &Game) : bool {

        let player_one_rider_confirmed = game.player_one_rider_confirmed;

        player_one_rider_confirmed
    }


    // player one soldier status
    public fun player_one_soldier_confirmed(game: &Game) : bool {

        let player_one_soldier_confirmed = game.player_one_soldier_confirmed;

        player_one_soldier_confirmed
    }



    // player two general status
    public fun player_two_general_confirmed(game: &Game) : bool {

        let player_two_general_confirmed = game.player_two_general_confirmed;

        player_two_general_confirmed
    }


    // player two monster status
    public fun player_two_monster_confirmed(game: &Game) : bool {

        let player_two_monster_confirmed = game.player_two_monster_confirmed;

        player_two_monster_confirmed
    }


    // player two rider status
    public fun player_two_rider_confirmed(game: &Game) : bool {

        let player_two_rider_confirmed = game.player_two_rider_confirmed;

        player_two_rider_confirmed
    }


    // player two soldier status
    public fun player_two_soldier_confirmed(game: &Game) : bool {

        let player_two_soldier_confirmed = game.player_two_soldier_confirmed;

        player_two_soldier_confirmed
    }








    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // END OF GAME CHECKS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------


    // struct transferresentd to the winner and used to claim the bet pot
    struct Trophy has key, store {
        id: UID,
        winner: address,
    }


    
    // winner event
    struct Winner has copy, drop {
        player_one_winner: bool,
        player_two_winner: bool,
    }





    fun check_for_winner(game: &mut Game, ctx: &mut TxContext) {


        // if all cards are dead emit winner event
        if(game.player_one_soldier_status == 0 && game.player_one_monster_status == 0 && game.player_one_rider_status == 0 && game.player_one_general_status == 0) {
            
            event::emit( Winner {
                player_one_winner: false,
                player_two_winner: true,
            });

            let trophy = Trophy {
                id: object::new(ctx),
                winner: game.player_two_address,
            };

            transfer::public_transfer(trophy, game.player_two_address);


            game.winner = true;


        };


        // if all cards are dead emit winner event
        if(game.player_two_soldier_status == 0 && game.player_two_monster_status == 0 && game.player_two_rider_status == 0 && game.player_two_general_status == 0) {
            
            event::emit( Winner {
                player_one_winner: true,
                player_two_winner: false,
            });


            let trophy = Trophy {
                id: object::new(ctx),
                winner: game.player_one_address,
            };

            transfer::public_transfer(trophy, game.player_one_address);


            game.winner = true;

        };


        

    }




    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // BET FUNCTIONS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    

    // takes bets and puts them in the balance
    struct EscrowForBets has key, store {

        id: UID,
        balance: Balance<SUI>,
        player_one_contribution: u64,
        player_two_contribution: u64,

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
    // ADD CARD CHECKS
    // soldier vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_soldier_vs_capy_soldier(r: &Random, game: &mut Game, soldier_attack: &mut GnomeSoldier, gnome_soldier_owner_cap: &GnomeSoldierOwnerCap, soldier_defense: &mut CapySoldier, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        

        let address_attacker = soldier_attack.owner_address;
        let address_defender = soldier_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {

            current_player = 1;
            defender = 2;

        } else if (soldier_attack.owner_address == game.player_two_address) {

            current_player = 2;
            defender = 1;

        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(soldier_defense.type_id == 4, 99);





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



        // if defense card health is 0, emit death event and sets the status in the game to 0
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

        

    }



    

    // ADD CP COSTS
    // soldier vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_soldier_vs_capy_rider(r: &Random, game: &mut Game, soldier_attack: &mut GnomeSoldier, gnome_soldier_owner_cap: &GnomeSoldierOwnerCap, rider_defense: &mut CapyRider, ctx: &mut TxContext) {


        

        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = rider_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {

            current_player = 1;
            defender = 2;

        } else if (soldier_attack.owner_address == game.player_two_address) {

            current_player = 2;
            defender = 1;

        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(rider_defense.type_id == 3, 99);




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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);




    }




    // // ADD CP COSTS
    // soldier vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_soldier_vs_capy_monster(r: &Random, game: &mut Game, soldier_attack: &mut GnomeSoldier, gnome_soldier_owner_cap: &GnomeSoldierOwnerCap,  monster_defense: &mut CapyMonster, ctx: &mut TxContext) {


    
        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = monster_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (soldier_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(monster_defense.type_id == 2, 99);




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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }






    // ADD CP COSTS
    // soldier vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_soldier_vs_capy_general(r: &Random, game: &mut Game, soldier_attack: &mut GnomeSoldier, gnome_soldier_owner_cap: &GnomeSoldierOwnerCap, general_defense: &mut CapyGeneral,  ctx: &mut TxContext) {



        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = general_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (soldier_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(general_defense.type_id == 1, 99);



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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_general_status = 0;
            } else {
                game.player_two_general_status = 0;
            };
            

        };



        check_for_winner(game, ctx);





    }





    

    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // RIDER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // rider vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_rider_vs_capy_soldier(r: &Random, game: &mut Game, rider_attack: &mut GnomeRider, gnome_rider_owner_cap: &GnomeRiderOwnerCap, soldier_defense: &mut CapySoldier, ctx: &mut TxContext) {



        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = soldier_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(soldier_defense.type_id == 4, 99);



        // 66% probability of attack success
        if( sixty_six_percent_probability(r, ctx) == 1) {
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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }



    

    // ADD CP COSTS
    // rider vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_rider_vs_capy_rider(r: &Random, game: &mut Game, rider_attack: &mut GnomeRider, gnome_rider_owner_cap: &GnomeRiderOwnerCap, rider_defense: &mut CapyRider, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = rider_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(rider_defense.type_id == 3, 99);

    
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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);
 

    }




    // ADD CP COSTS
    // rider vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_rider_vs_capy_monster(r: &Random, game: &mut Game, rider_attack: &mut GnomeRider, gnome_rider_owner_cap: &GnomeRiderOwnerCap, monster_defense: &mut CapyMonster, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = monster_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(monster_defense.type_id == 2, 99);


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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

    }






    // ADD CP COSTS
    // rider vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_rider_vs_capy_general(r: &Random, game: &mut Game, rider_attack: &mut GnomeRider, gnome_rider_owner_cap: &GnomeRiderOwnerCap, general_defense: &mut CapyGeneral, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = general_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(general_defense.type_id == 1, 99);

    
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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_general_status = 0;
            } else {
                game.player_two_general_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }






    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // GNOME MONSTER ATTACK FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------



    // ADD CP COSTS
    // rider vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_monster_vs_capy_soldier(r: &Random, game: &mut Game, monster_attack: &mut GnomeMonster, gnome_rider_owner_cap: &GnomeMonsterOwnerCap, soldier_defense: &mut CapySoldier, ctx: &mut TxContext) {



        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = soldier_defense.owner_address;

        let attack_card_confirmed = false;
        let defense_card_confirmed = false;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(soldier_defense.type_id == 4, 99);



        // 66% probability of attack success
        if( sixty_six_percent_probability(r, ctx) == 1) {
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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);
 

    }



    

    // ADD CP COSTS
    // monster vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_monster_vs_capy_rider(r: &Random, game: &mut Game, monster_attack: &mut GnomeMonster, gnome_rider_owner_cap: &GnomeMonsterOwnerCap, rider_defense: &mut CapyRider, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = rider_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(rider_defense.type_id == 3, 99);

    
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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

    }




    // ADD CP COSTS
    // monster vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_monster_vs_capy_monster(r: &Random, game: &mut Game, monster_attack: &mut GnomeMonster, gnome_rider_owner_cap: &GnomeMonsterOwnerCap, monster_defense: &mut CapyMonster, ctx: &mut TxContext) {



        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = monster_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(monster_defense.type_id == 2, 99);


    
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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

    }






    // ADD CP COSTS
    // monster vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_monster_vs_capy_general(r: &Random, game: &mut Game, monster_attack: &mut GnomeMonster, gnome_rider_owner_cap: &GnomeMonsterOwnerCap, general_defense: &mut CapyGeneral, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = general_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(general_defense.type_id == 1, 99);

    
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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_general_status = 0;
            } else {
                game.player_two_general_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }







    



    
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // GNOME GENERAL ATTACK FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------




    
    // ADD CP COSTS
    // general vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_general_vs_capy_soldier(r: &Random, game: &mut Game, general_attack: &mut GnomeGeneral, gnome_general_owner_cap: &GnomeGeneralOwnerCap, soldier_defense: &mut CapySoldier, ctx: &mut TxContext) {



        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = soldier_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(soldier_defense.type_id == 4, 99);

    
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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

        

    }



    

    // // ADD CP COSTS
    // general vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_general_vs_capy_rider(r: &Random, game: &mut Game, general_attack: &mut GnomeGeneral, gnome_general_owner_cap: &GnomeGeneralOwnerCap, rider_defense: &mut CapyRider, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = rider_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(rider_defense.type_id == 3, 99);


    
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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }




    // ADD CP COSTS
    // general vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_general_vs_capy_monster(r: &Random, game: &mut Game, general_attack: &mut GnomeGeneral, gnome_general_owner_cap: &GnomeGeneralOwnerCap, monster_defense: &mut CapyMonster, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = monster_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(monster_defense.type_id == 2, 99);

    
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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);


  
    }






    // general vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun gnome_general_vs_capy_general(r: &Random, game: &mut Game, general_attack: &mut GnomeGeneral, gnome_general_owner_cap: &GnomeGeneralOwnerCap, general_defense: &mut CapyGeneral, ctx: &mut TxContext) {



         // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = general_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(general_defense.type_id == 1, 99);

    
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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_general_status = 0;
            } else {
                game.player_two_general_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

        

    }















    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // CAPY ATTACK FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    
    
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // CAPY SOLDIER ATTACK FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------


    #[allow(unused_variable, unused_assignment)]
    entry fun capy_soldier_vs_gnome_soldier(r: &Random, game: &mut Game, soldier_attack: &mut CapySoldier, capy_soldier_owner_cap: &CapySoldierOwnerCap, soldier_defense: &mut GnomeSoldier, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = soldier_defense.owner_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (soldier_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(soldier_defense.type_id == 4, 99);


        // checks cards is still in gameplay
        if(game.player_one_soldier_status == 0 && current_player == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && current_player == 2) {
            abort(1)
        };


        if(game.player_one_soldier_status == 0 && defender == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && defender == 2) {
            abort(1)
        };


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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

        

    }









    // soldier vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_soldier_vs_gnome_rider(r: &Random, game: &mut Game, soldier_attack: &mut CapySoldier, capy_soldier_owner_cap: &CapySoldierOwnerCap, rider_defense: &mut GnomeRider,  ctx: &mut TxContext) {


    
        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = rider_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (soldier_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(rider_defense.type_id == 3, 99);




        // checks cards is still in gameplay
        if(game.player_one_soldier_status == 0 && current_player == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && current_player == 2) {
            abort(1)
        };


        if(game.player_one_soldier_status == 0 && defender == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && defender == 2) {
            abort(1)
        };



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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };


        check_for_winner(game, ctx);


    }






    #[allow(unused_variable, unused_assignment)]
    entry fun capy_soldier_vs_gnome_monster(r: &Random, game: &mut Game, soldier_attack: &mut CapySoldier, capy_soldier_owner_cap: &CapySoldierOwnerCap, monster_defense: &mut GnomeMonster, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = monster_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (soldier_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(monster_defense.type_id == 2, 99);




        // checks cards is still in gameplay
        if(game.player_one_soldier_status == 0 && current_player == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && current_player == 2) {
            abort(1)
        };


        if(game.player_one_soldier_status == 0 && defender == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && defender == 2) {
            abort(1)
        };


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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }



    // soldier vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_soldier_vs_gnome_general(r: &Random, game: &mut Game, soldier_attack: &mut CapySoldier, capy_soldier_owner_cap: &CapySoldierOwnerCap, general_defense: &mut GnomeGeneral, ctx: &mut TxContext) {


        
        // vars
        let successful = false; 
        let address_attacker = soldier_attack.owner_address;
        let address_defender = general_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (soldier_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (soldier_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(soldier_attack.type_id == 4, 99);
        assert!(general_defense.type_id == 1, 99);




        // checks cards is still in gameplay
        if(game.player_one_soldier_status == 0 && current_player == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && current_player == 2) {
            abort(1)
        };


        if(game.player_one_soldier_status == 0 && defender == 1) {
            abort(1)
        } else if (game.player_two_soldier_status == 0 && defender == 2) {
            abort(1)
        };



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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_general_status = 0;
            } else {
                game.player_two_general_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }



    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------
    // RIDER ATTACK FUNCTIONS
    // -------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------



    
    // ADD CP COSTS
    // rider vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_rider_vs_gnome_soldier(r: &Random, game: &mut Game, rider_attack: &mut CapyRider, capy_rider_owner_cap: &CapyRiderOwnerCap, soldier_defense: &mut GnomeSoldier, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = soldier_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(soldier_defense.type_id == 4, 99);




        // checks cards is still in gameplay
        if(game.player_one_rider_status == 0 && current_player == 1) {
            abort(1)
        } else if (game.player_two_rider_status == 0 && current_player == 2) {
            abort(1)
        };


        if(game.player_one_rider_status == 0 && defender == 1) {
            abort(1)
        } else if (game.player_two_rider_status == 0 && defender == 2) {
            abort(1)
        };


       


        // 66% probability of attack success
        if( sixty_six_percent_probability(r, ctx) == 1) {
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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }


    // rider vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_rider_vs_gnome_rider(r: &Random, game: &mut Game, rider_attack: &mut CapyRider, capy_rider_owner_cap: &CapyRiderOwnerCap, rider_defense: &mut GnomeRider, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = rider_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(rider_defense.type_id == 3, 99);


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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);


        

    }




    // rider vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_rider_vs_gnome_monster(r: &Random, game: &mut Game, rider_attack: &mut CapyRider, capy_rider_owner_cap: &CapyRiderOwnerCap, monster_defense: &mut GnomeMonster, ctx: &mut TxContext) {



        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = monster_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(monster_defense.type_id == 2, 99);


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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }




    // rider vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_rider_vs_gnome_general(r: &Random, game: &mut Game, rider_attack: &mut CapyRider, gnome_rider_owner_cap: &CapyRiderOwnerCap, general_defense: &mut GnomeGeneral, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = rider_attack.owner_address;
        let address_defender = general_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (rider_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (rider_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(rider_attack.type_id == 3, 99);
        assert!(general_defense.type_id == 1, 99);

    
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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_general_status = 0;
            } else {
                game.player_two_general_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }












    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // CAPY MONSTER ATTACK FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------






    // ADD CP COSTS
    // rider vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_monster_vs_gnome_soldier(r: &Random, game: &mut Game, monster_attack: &mut CapyMonster, gnome_rider_owner_cap: &CapyMonsterOwnerCap, soldier_defense: &mut GnomeSoldier, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = soldier_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(soldier_defense.type_id == 4, 99);


        // 66% probability of attack success
        if( sixty_six_percent_probability(r, ctx) == 1) {
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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }



    

    // ADD CP COSTS
    // monster vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_monster_vs_gnome_rider(r: &Random, game: &mut Game, monster_attack: &mut CapyMonster, gnome_rider_owner_cap: &CapyMonsterOwnerCap, rider_defense: &mut GnomeRider, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = rider_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(rider_defense.type_id == 3, 99);
    
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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);


    }




    // ADD CP COSTS
    // monster vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_monster_vs_gnome_monster(r: &Random, game: &mut Game, monster_attack: &mut CapyMonster, gnome_rider_owner_cap: &CapyMonsterOwnerCap, monster_defense: &mut GnomeMonster, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = monster_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(monster_defense.type_id == 2, 99);

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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);




    }






    // ADD CP COSTS
    // monster vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_monster_vs_gnome_general(r: &Random, game: &mut Game, monster_attack: &mut CapyMonster, gnome_rider_owner_cap: &CapyMonsterOwnerCap, general_defense: &mut GnomeGeneral, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = monster_attack.owner_address;
        let address_defender = general_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (monster_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (monster_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(monster_attack.type_id == 2, 99);
        assert!(general_defense.type_id == 1, 99);

    
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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);



    }














    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------
    // CAPY GENERAL ATTACK FUNCTIONS
    // -----------------------------------------------------------------------
    // -----------------------------------------------------------------------


    // ADD CP COSTS
    // general vs soldier
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_general_vs_gnome_soldier(r: &Random, game: &mut Game, general_attack: &mut CapyGeneral, gnome_general_owner_cap: &CapyGeneralOwnerCap, soldier_defense: &mut GnomeSoldier,  ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = soldier_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(soldier_defense.type_id == 4, 99);

    
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



        // if defense card health is 0, emit death event
        if(soldier_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_soldier_status = 0;
            } else {
                game.player_two_soldier_status = 0;
            };
            

        };



        check_for_winner(game, ctx);

    }



    

    // // ADD CP COSTS
    // general vs rider
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_general_vs_gnome_rider(r: &Random, game: &mut Game, general_attack: &mut CapyGeneral, gnome_general_owner_cap: &CapyGeneralOwnerCap, rider_defense: &mut GnomeRider, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = rider_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(rider_defense.type_id == 3, 99);


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



        // if defense card health is 0, emit death event
        if(rider_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_rider_status = 0;
            } else {
                game.player_two_rider_status = 0;
            };
            

        };



        check_for_winner(game, ctx);
  

    }




    // ADD CP COSTS
    // general vs monster
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_general_vs_gnome_monster(r: &Random, game: &mut Game, general_attack: &mut CapyGeneral, gnome_general_owner_cap: &CapyGeneralOwnerCap, monster_defense: &mut GnomeMonster, ctx: &mut TxContext) {


        // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = monster_defense.owner_address;

        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(monster_defense.type_id == 2, 99);

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



        // if defense card health is 0, emit death event
        if(monster_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };


        check_for_winner(game, ctx);



    }






    // general vs general
    #[allow(unused_variable, unused_assignment)]
    entry fun capy_general_vs_gnome_general(r: &Random, game: &mut Game, general_attack: &mut CapyGeneral, gnome_general_owner_cap: &CapyGeneralOwnerCap, general_defense: &mut GnomeGeneral, ctx: &mut TxContext) {


         // vars
        let successful = false; 
        let address_attacker = general_attack.owner_address;
        let address_defender = general_defense.owner_address;


        let player_one_address = game.player_one_address;
        let player_two_address = game.player_two_address;

        let current_player = 0;
        let defender = 0;



        if (general_attack.owner_address == game.player_one_address) {
            current_player = 1;
            defender = 2;
        } else if (general_attack.owner_address == game.player_two_address) {
            current_player = 2;
            defender = 1;
        };
        
        
        // checks cards are correct type
        assert!(general_attack.type_id == 1, 99);
        assert!(general_defense.type_id == 1, 99);

    
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



        // if defense card health is 0, emit death event
        if(general_defense.health == 0) {

            event::emit(Death {
                death: true,
            });

            if (defender == 1) {
                game.player_one_monster_status = 0;
            } else {
                game.player_two_monster_status = 0;
            };
            

        };



        check_for_winner(game, ctx);


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




    // --------------------------------------------------------------------------
    // --------------------------------------------------------------------------
    // DEFENSIVE POSTURE
    // --------------------------------------------------------------------------
    // --------------------------------------------------------------------------



    struct DefenseCardAttacked has copy, drop {
        type_id: u8,
    }



    // choice 1 for backline and 2 for frontline stance
    entry fun defensive_posture(r: &Random, choice: u8, ctx: &mut TxContext): u8 {

        let card_selected_type: u8;

        if (choice == 1) {

            card_selected_type = backline_defense_stance(r, ctx);

            event::emit(DefenseCardAttacked {
                type_id: card_selected_type,
            });

            card_selected_type

        } else if (choice == 2) {

            card_selected_type = frontline_defense_stance(r, ctx);

            event::emit(DefenseCardAttacked {
                type_id: card_selected_type,
            });

            card_selected_type

        } else {

            
            card_selected_type = 0; 

            event::emit(DefenseCardAttacked {
                type_id: card_selected_type,
            });

            card_selected_type

        }

    
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
    // PROBABILITY FUNCTIONS
    //--------------------------------------------------------------------------------
    // -------------------------------------------------------------------------------




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




