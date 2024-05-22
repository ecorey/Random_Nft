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
    // use capy_vs_gnome::card_deck::{Card, Game, TurnKey};
    // use capy_vs_gnome::card_deck::{start_game, turn_trial, first_turn};
    // use capy_vs_gnome::card_deck::{HashedSelection, HashedSelectionProved, HashedSelectionMade, HashedSelectionProvedMade};
    // use capy_vs_gnome::card_deck::{ hashed_selection, prove_hashed_selection };



    



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
            
           

        };




        // mint capy deck and delete capy deck
        test_scenario::next_tx(scenario_val, admin);
        {
        
           
        };





        // create decks, confirm and test getters
        test_scenario::next_tx(scenario_val, admin);
        {
            

        };




        // 
        test_scenario::next_tx(scenario_val, admin );
        {



        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };















        test_scenario::end(scenario);



    }













}