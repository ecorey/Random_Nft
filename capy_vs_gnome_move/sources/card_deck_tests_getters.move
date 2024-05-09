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

            // create capy deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = confirm_deck_for_testing(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val));



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


            // check getters (gnome monster)
            let address_monster = owner_address(&gnome_monster);
            debug::print<address>(&address_monster);

            let type_monster = type(&gnome_monster);
            debug::print<String>(&type_monster);

            let type_id_monster = type_id(&gnome_monster);
            debug::print<u64>(&type_id_monster);

            let name_monster = name(&gnome_monster);
            debug::print<String>(&name_monster);

            let image_url_monster = image_url(&gnome_monster);
            debug::print<String>(&image_url_monster);

            let attack_general = attack(&gnome_general);
            debug::print<u64>(&attack_general);

            let defense_monster = defense(&gnome_monster);
            debug::print<u64>(&defense_monster);

            let health_monster = health(&gnome_monster);
            debug::print<u64>(&health_monster);

            let cost_monster = cost(&gnome_monster);
            debug::print<u64>(&cost_monster);



            // check getters (gnome rider)
            let address_rider = owner_address(&gnome_rider);
            debug::print<address>(&address_rider);

            let type_rider = type(&gnome_rider);
            debug::print<String>(&type_rider);

            let type_id_rider = type_id(&gnome_rider);
            debug::print<u64>(&type_id_rider);

            let name_rider = name(&gnome_rider);
            debug::print<String>(&name_rider);

            let image_url_rider = image_url(&gnome_rider);
            debug::print<String>(&image_url_rider);

            let attack_rider = attack(&gnome_rider);
            debug::print<u64>(&attack_rider);

            let defense_rider = defense(&gnome_rider);
            debug::print<u64>(&defense_rider);

            let health_rider = health(&gnome_rider);
            debug::print<u64>(&health_rider);

            let cost_rider = cost(&gnome_rider);
            debug::print<u64>(&cost_rider);




            // check getters (gnome soldier)
            let address_soldier = owner_address(&gnome_soldier);
            debug::print<address>(&address_soldier);

            let type_soldier = type(&gnome_soldier);
            debug::print<String>(&type_soldier);

            let type_id_soldier = type_id(&gnome_soldier);
            debug::print<u64>(&type_id_soldier);

            let name_soldier = name(&gnome_soldier);
            debug::print<String>(&name_soldier);

            let image_url_soldier = image_url(&gnome_soldier);
            debug::print<String>(&image_url_soldier);

            let attack_soldier = attack(&gnome_soldier);
            debug::print<u64>(&attack_soldier);

            let defense_soldier = defense(&gnome_soldier);
            debug::print<u64>(&defense_soldier);

            let health_soldier = health(&gnome_soldier);
            debug::print<u64>(&health_soldier);

            let cost_soldier = cost(&gnome_soldier);
            debug::print<u64>(&cost_soldier);





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



            // check getters (capy general)
            let address_general = owner_address(&capy_general);
            debug::print<address>(&address_general);

            let type_general = type(&capy_general);
            debug::print<String>(&type_general);

            let type_id_general = type_id(&capy_general);
            debug::print<u64>(&type_id_general);

            let name_general = name(&capy_general);
            debug::print<String>(&name_general);

            let image_url_general = image_url(&capy_general);
            debug::print<String>(&image_url_general);

            let attack_general = attack(&capy_general);
            debug::print<u64>(&attack_general);

            let defense_general = defense(&capy_general);
            debug::print<u64>(&defense_general);

            let health_general = health(&capy_general);
            debug::print<u64>(&health_general);

            let cost_general = cost(&capy_general);
            debug::print<u64>(&cost_general);


            // check getters (capy monster)
            let address_monster = owner_address(&capy_monster);
            debug::print<address>(&address_monster);

            let type_monster = type(&capy_monster);
            debug::print<String>(&type_monster);

            let type_id_monster = type_id(&capy_monster);
            debug::print<u64>(&type_id_monster);

            let name_monster = name(&capy_monster);
            debug::print<String>(&name_monster);

            let image_url_monster = image_url(&capy_monster);
            debug::print<String>(&image_url_monster);

            let attack_general = attack(&capy_monster);
            debug::print<u64>(&attack_general);

            let defense_monster = defense(&capy_monster);
            debug::print<u64>(&defense_monster);

            let health_monster = health(&capy_monster);
            debug::print<u64>(&health_monster);

            let cost_monster = cost(&capy_monster);
            debug::print<u64>(&cost_monster);



            // check getters (capy rider)
            let address_rider = owner_address(&capy_rider);
            debug::print<address>(&address_rider);

            let type_rider = type(&capy_rider);
            debug::print<String>(&type_rider);

            let type_id_rider = type_id(&capy_rider);
            debug::print<u64>(&type_id_rider);

            let name_rider = name(&capy_rider);
            debug::print<String>(&name_rider);

            let image_url_rider = image_url(&capy_rider);
            debug::print<String>(&image_url_rider);

            let attack_rider = attack(&capy_rider);
            debug::print<u64>(&attack_rider);

            let defense_rider = defense(&capy_rider);
            debug::print<u64>(&defense_rider);

            let health_rider = health(&capy_rider);
            debug::print<u64>(&health_rider);

            let cost_rider = cost(&capy_rider);
            debug::print<u64>(&cost_rider);




            // check getters (capy soldier)
            let address_soldier = owner_address(&capy_soldier);
            debug::print<address>(&address_soldier);

            let type_soldier = type(&capy_soldier);
            debug::print<String>(&type_soldier);

            let type_id_soldier = type_id(&capy_soldier);
            debug::print<u64>(&type_id_soldier);

            let name_soldier = name(&capy_soldier);
            debug::print<String>(&name_soldier);

            let image_url_soldier = image_url(&capy_soldier);
            debug::print<String>(&image_url_soldier);

            let attack_soldier = attack(&capy_soldier);
            debug::print<u64>(&attack_soldier);

            let defense_soldier = defense(&capy_soldier);
            debug::print<u64>(&defense_soldier);

            let health_soldier = health(&capy_soldier);
            debug::print<u64>(&health_soldier);

            let cost_soldier = cost(&capy_soldier);
            debug::print<u64>(&cost_soldier);





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