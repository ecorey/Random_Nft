#[test_only]
module capy_vs_gnome::card_deck_tests {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};
    // use capy_vs_gnome::card_deck::{mint_complete_gnome_deck};
    // use capy_vs_gnome::card_deck::{mint_capy_deck, delete_capy_deck};
    // use capy_vs_gnome::card_deck::{delete_complete_gnome_deck};

    use capy_vs_gnome::card_deck::{gnome_deck, delete_all_gnome_cards};

   


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
            
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = gnome_deck(test_scenario::ctx(scenario_val));
            
            
            delete_all_gnome_cards(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val)); 



        };




        // mint capy deck and delete capy deck
        test_scenario::next_tx(scenario_val, admin);
        {
        
            // let deck = mint_capy_deck(test_scenario::ctx(scenario_val));
            // delete_capy_deck(deck);

        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };




        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
       

        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            

        };















        test_scenario::end(scenario);



    }













}