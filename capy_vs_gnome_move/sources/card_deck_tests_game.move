#[test_only]
module capy_vs_gnome::card_deck_tests_game {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};


    // GAME IMPORTS
    use capy_vs_gnome::card_deck::{Card, Game, TurnKey};
    use capy_vs_gnome::card_deck::{mint_gnome_cards, delete_all_gnome_cards};
    use capy_vs_gnome::card_deck::{capy_deck, delete_all_capy_cards};
    use capy_vs_gnome::card_deck::{confirm_deck_for_testing};
    use capy_vs_gnome::card_deck::{start_game, turn_trial, first_turn};
    use capy_vs_gnome::card_deck::{HashedSelection, HashedSelectionProved, HashedSelectionMade, HashedSelectionProvedMade};
    use capy_vs_gnome::card_deck::{ hashed_selection, prove_hashed_selection };


    // GAME GETTERS
    use capy_vs_gnome::card_deck::{ player_one_address, player_two_address, coin_flip_guess, coin_flip_count, coin_flip_result};
    use capy_vs_gnome::card_deck::{ even_turns, odd_turns, turn_count, confirm_deck_player_one, confirm_deck_player_two};
    use capy_vs_gnome::card_deck::{ player_one_general_status, player_one_monster_status, player_one_rider_status, player_one_soldier_status};
    use capy_vs_gnome::card_deck::{ player_two_general_status, player_two_monster_status, player_two_rider_status, player_two_soldier_status};

    
   
   
    



    fun init_test_helper() : test_scenario::Scenario {

        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = test_scenario::begin(admin);
        let scenario_val = &mut scenario;

        let otw = create_one_time_witness<CARD_DECK>();


        {
            init_for_testing(otw, test_scenario::ctx(scenario_val));
        };

        scenario



    }



    #[test]
    public fun character_card_cards() {


        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = init_test_helper();
        let scenario_val = &mut scenario;
        let ctx = test_scenario::ctx(scenario_val);



        
        // TEST DECKS
        // mint gnome deck and delete gnome deck
        test_scenario::next_tx(scenario_val, admin);
        {
            
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_cards(test_scenario::ctx(scenario_val));
            
            
            delete_all_gnome_cards(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val)); 


        };




        // mint capy deck and delete capy deck
        test_scenario::next_tx(scenario_val, admin);
        {
        
            let (capy_general, capy_monster, capy_rider, capy_soldier) = capy_deck(test_scenario::ctx(scenario_val));
            
            
            delete_all_capy_cards(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val)); 

        };





        // create decks, confirm and test getters
        test_scenario::next_tx(scenario_val, admin);
        {
            
            // create gnome deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_cards(test_scenario::ctx(scenario_val));

            // create capy deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = confirm_deck_for_testing(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val));







            // delete the decks
            delete_all_gnome_cards(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val)); 



        };




        // 
        test_scenario::next_tx(scenario_val, admin );
        {


            // create gnome deck and confirm it
            let (capy_general, capy_monster, capy_rider, capy_soldier) = capy_deck(test_scenario::ctx(scenario_val));

            // create capy deck and confirm it
            let (capy_general, capy_monster, capy_rider, capy_soldier) = confirm_deck_for_testing(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val));








            // delete the decks
            delete_all_capy_cards(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val)); 



        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };















        test_scenario::end(scenario);



    }













}