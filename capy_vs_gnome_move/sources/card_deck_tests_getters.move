#[test_only]
module capy_vs_gnome::card_deck_tests_getters {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};


    use capy_vs_gnome::card_deck::{Card};
    use capy_vs_gnome::card_deck::{gnome_deck, delete_all_gnome_cards};
    use capy_vs_gnome::card_deck::{capy_deck, delete_all_capy_cards};
    use capy_vs_gnome::card_deck::{confirm_deck_for_testing};
    use capy_vs_gnome::card_deck::{owner_address, type,  type_id, name,  image_url, attack, defense, health, cost};
    


    use capy_vs_gnome::card_deck::{soldier_vs_soldier};



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
        
            let (capy_general, capy_monster, capy_rider, capy_soldier) = capy_deck(test_scenario::ctx(scenario_val));
            
            
            delete_all_capy_cards(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val)); 

        };





        // create decks, confirm and test getters
        test_scenario::next_tx(scenario_val, admin);
        {
            
            // create gnome deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = gnome_deck(test_scenario::ctx(scenario_val));
            let (capy_general, capy_monster, capy_rider, capy_soldier) = capy_deck(test_scenario::ctx(scenario_val));

            // create capy deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = confirm_deck_for_testing(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val));
            let (capy_general, capy_monster, capy_rider, capy_soldier) = confirm_deck_for_testing(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val));



            // check getters (gnome general)
            let address_general = owner_address(&gnome_general);
            debug::print<address>(&address_general);

            let type_general = type(&gnome_general);
            debug::print<String>(&type_general);

            let type_id_general = type_id(&gnome_general);
            debug::print<u64>(&type_id_general);

            let name_general = name(&gnome_general);
            debug::print<String>(&name_general);

            let image_url_general = image_url(&gnome_general);
            debug::print<String>(&image_url_general);

            let attack_general = attack(&gnome_general);
            debug::print<u64>(&attack_general);

            let defense_general = defense(&gnome_general);
            debug::print<u64>(&defense_general);

            let health_general = health(&gnome_general);
            debug::print<u64>(&health_general);

            let cost_general = cost(&gnome_general);
            debug::print<u64>(&cost_general);


            
            // delete the decks
            delete_all_gnome_cards(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val)); 
            delete_all_capy_cards(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val)); 



        };




        // 
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