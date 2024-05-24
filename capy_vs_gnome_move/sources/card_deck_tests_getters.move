#[test_only]
module capy_vs_gnome::card_deck_tests_getters {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};


    use capy_vs_gnome::card_deck::{GnomeGeneral, GnomeMonster, GnomeRider, GnomeSoldier};
    use capy_vs_gnome::card_deck::{CapyGeneral, CapyMonster, CapyRider, CapySoldier};
    use capy_vs_gnome::card_deck::{mint_gnome_cards, delete_all_gnome_card_caps};
    use capy_vs_gnome::card_deck::{mint_capy_cards, delete_all_capy_card_caps};
    use capy_vs_gnome::card_deck::{confirm_gnome_deck, confirm_capy_deck};
    use capy_vs_gnome::card_deck::{owner_address_gnome_general, owner_address_gnome_monster, owner_address_gnome_rider, owner_address_gnome_soldier};
    use capy_vs_gnome::card_deck::{type_gnome_general, type_gnome_monster, type_gnome_rider, type_gnome_soldier};
    use capy_vs_gnome::card_deck::{type_id_gnome_general, type_id_gnome_monster, type_id_gnome_rider, type_id_gnome_soldier};
    use capy_vs_gnome::card_deck::{name_gnome_general, name_gnome_monster, name_gnome_rider, name_gnome_soldier};
    use capy_vs_gnome::card_deck::{image_url_gnome_general, image_url_gnome_monster, image_url_gnome_rider, image_url_gnome_soldier};
    use capy_vs_gnome::card_deck::{attack_gnome_general, attack_gnome_monster, attack_gnome_rider, attack_gnome_soldier};
    use capy_vs_gnome::card_deck::{defense_gnome_general, defense_gnome_monster, defense_gnome_rider, defense_gnome_soldier};
    use capy_vs_gnome::card_deck::{health_gnome_general, health_gnome_monster, health_gnome_rider, health_gnome_soldier};
    use capy_vs_gnome::card_deck::{cost_gnome_general, cost_gnome_monster, cost_gnome_rider, cost_gnome_soldier};

    use capy_vs_gnome::card_deck::{owner_address_capy_general, owner_address_capy_monster, owner_address_capy_rider, owner_address_capy_soldier};
    use capy_vs_gnome::card_deck::{type_capy_general, type_capy_monster, type_capy_rider, type_capy_soldier};
    use capy_vs_gnome::card_deck::{type_id_capy_general, type_id_capy_monster, type_id_capy_rider, type_id_capy_soldier};
    use capy_vs_gnome::card_deck::{name_capy_general, name_capy_monster, name_capy_rider, name_capy_soldier};
    use capy_vs_gnome::card_deck::{image_url_capy_general, image_url_capy_monster, image_url_capy_rider, image_url_capy_soldier};
    use capy_vs_gnome::card_deck::{attack_capy_general, attack_capy_monster, attack_capy_rider, attack_capy_soldier};
    use capy_vs_gnome::card_deck::{defense_capy_general, defense_capy_monster, defense_capy_rider, defense_capy_soldier};
    use capy_vs_gnome::card_deck::{health_capy_general, health_capy_monster, health_capy_rider, health_capy_soldier};
    use capy_vs_gnome::card_deck::{cost_capy_general, cost_capy_monster, cost_capy_rider, cost_capy_soldier};




    // use capy_vs_gnome::card_deck::{soldier_vs_soldier};


    #[allow(unused_variable)]
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
            
            let (gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap) = mint_gnome_cards(test_scenario::ctx(scenario_val));
            
            



            delete_all_gnome_card_caps(gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap, test_scenario::ctx(scenario_val)); 


        };




         // test gnome confirm deck
        test_scenario::next_tx(scenario_val, admin);
        {
            
            // create gnome deck 
            let (gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap) = mint_gnome_cards(test_scenario::ctx(scenario_val));



            // get shared obj
            let gnome_general = test_scenario::take_shared<GnomeGeneral>(scenario_val);
            let gnome_monster = test_scenario::take_shared<GnomeMonster>(scenario_val);
            let gnome_rider = test_scenario::take_shared<GnomeRider>(scenario_val);
            let gnome_soldier = test_scenario::take_shared<GnomeSoldier>(scenario_val);


            confirm_gnome_deck(&gnome_general, &gnome_general_owner_cap, &gnome_monster, &gnome_monster_owner_cap, &gnome_rider, &gnome_rider_owner_cap, &gnome_soldier, &gnome_soldier_owner_cap, test_scenario::ctx(scenario_val));

            test_scenario::return_shared(gnome_general);
            test_scenario::return_shared(gnome_monster);
            test_scenario::return_shared(gnome_rider);
            test_scenario::return_shared(gnome_soldier);

            // delete the decks
            delete_all_gnome_card_caps(gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap, test_scenario::ctx(scenario_val)); 



        };



        // test gnome getters
        test_scenario::next_tx(scenario_val, admin);
        {


            // create gnome deck 
            let (gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap) = mint_gnome_cards(test_scenario::ctx(scenario_val));



            // get shared obj
            let gnome_general = test_scenario::take_shared<GnomeGeneral>(scenario_val);
            let gnome_monster = test_scenario::take_shared<GnomeMonster>(scenario_val);
            let gnome_rider = test_scenario::take_shared<GnomeRider>(scenario_val);
            let gnome_soldier = test_scenario::take_shared<GnomeSoldier>(scenario_val);





        


            // check getters (gnome general)
            let address_general = owner_address_gnome_general(&gnome_general);
            debug::print<address>(&address_general);

            let type_general = type_gnome_general(&gnome_general);
            debug::print<String>(&type_general);


            let type_id_general = type_id_gnome_general(&gnome_general);
            debug::print<u64>(&type_id_general);

            let name_general = name_gnome_general(&gnome_general);
            debug::print<String>(&name_general);

            let image_url_general = image_url_gnome_general(&gnome_general);
            debug::print<String>(&image_url_general);

            let attack_general = attack_gnome_general(&gnome_general);
            debug::print<u64>(&attack_general);

            let defense_general = defense_gnome_general(&gnome_general);
            debug::print<u64>(&defense_general);

            let health_general = health_gnome_general(&gnome_general);
            debug::print<u64>(&health_general);

            let cost_general = cost_gnome_general(&gnome_general);
            debug::print<u64>(&cost_general);


            // check getters (gnome monster)
            let address_monster = owner_address_gnome_monster(&gnome_monster);
            debug::print<address>(&address_monster);

            let type_monster = type_gnome_monster(&gnome_monster);
            debug::print<String>(&type_monster);

            let type_id_monster = type_id_gnome_monster(&gnome_monster);
            debug::print<u64>(&type_id_monster);

            let name_monster = name_gnome_monster(&gnome_monster);
            debug::print<String>(&name_monster);

            let image_url_monster = image_url_gnome_monster(&gnome_monster);
            debug::print<String>(&image_url_monster);

            let attack_monster = attack_gnome_monster(&gnome_monster);
            debug::print<u64>(&attack_monster);

            let defense_monster = defense_gnome_monster(&gnome_monster);
            debug::print<u64>(&defense_monster);

            let health_monster = health_gnome_monster(&gnome_monster);
            debug::print<u64>(&health_monster);

            let cost_monster = cost_gnome_monster(&gnome_monster);
            debug::print<u64>(&cost_monster);



            // // check getters (gnome rider)
            let address_rider = owner_address_gnome_rider(&gnome_rider);
            debug::print<address>(&address_rider);

            let type_rider = type_gnome_rider(&gnome_rider);
            debug::print<String>(&type_rider);

            let type_id_rider = type_id_gnome_rider(&gnome_rider);
            debug::print<u64>(&type_id_rider);

            let name_rider = name_gnome_rider(&gnome_rider);
            debug::print<String>(&name_rider);

            let image_url_rider = image_url_gnome_rider(&gnome_rider);
            debug::print<String>(&image_url_rider);

            let attack_rider = attack_gnome_rider(&gnome_rider);
            debug::print<u64>(&attack_rider);

            let defense_rider = defense_gnome_rider(&gnome_rider);
            debug::print<u64>(&defense_rider);

            let health_rider = health_gnome_rider(&gnome_rider);
            debug::print<u64>(&health_rider);

            let cost_rider = cost_gnome_rider(&gnome_rider);
            debug::print<u64>(&cost_rider);




            // // check getters (gnome soldier)
            let address_soldier = owner_address_gnome_soldier(&gnome_soldier);
            debug::print<address>(&address_soldier);

            let type_soldier = type_gnome_soldier(&gnome_soldier);
            debug::print<String>(&type_soldier);

            let type_id_soldier = type_id_gnome_soldier(&gnome_soldier);
            debug::print<u64>(&type_id_soldier);

            let name_soldier = name_gnome_soldier(&gnome_soldier);
            debug::print<String>(&name_soldier);

            let image_url_soldier = image_url_gnome_soldier(&gnome_soldier);
            debug::print<String>(&image_url_soldier);

            let attack_soldier = attack_gnome_soldier(&gnome_soldier);
            debug::print<u64>(&attack_soldier);

            let defense_soldier = defense_gnome_soldier(&gnome_soldier);
            debug::print<u64>(&defense_soldier);

            let health_soldier = health_gnome_soldier(&gnome_soldier);
            debug::print<u64>(&health_soldier);

            let cost_soldier = cost_gnome_soldier(&gnome_soldier);
            debug::print<u64>(&cost_soldier);



            
            test_scenario::return_shared(gnome_general);
            test_scenario::return_shared(gnome_monster);
            test_scenario::return_shared(gnome_rider);
            test_scenario::return_shared(gnome_soldier);






            // delete the decks
            delete_all_gnome_card_caps(gnome_general_owner_cap, gnome_monster_owner_cap, gnome_rider_owner_cap, gnome_soldier_owner_cap, test_scenario::ctx(scenario_val)); 





            

        };




        // test capy mint, take objects, return objects and delete owner caps
        test_scenario::next_tx(scenario_val, admin );
        {


            // create capy deck 
            let (capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap) = mint_capy_cards(test_scenario::ctx(scenario_val));


            


            // delete the decks
            delete_all_capy_card_caps(capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap, test_scenario::ctx(scenario_val)); 



        };




        // test capy confirm deck
        // test_scenario::next_tx(scenario_val, admin );
        // {


          


        // };







        // // test capy getters
        test_scenario::next_tx(scenario_val, admin );
        {


            // create gnome deck and confirm it
            let (capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap) = mint_capy_cards(test_scenario::ctx(scenario_val));



            // get shared obj
            let capy_general = test_scenario::take_shared<CapyGeneral>(scenario_val);
            let capy_monster = test_scenario::take_shared<CapyMonster>(scenario_val);
            let capy_rider = test_scenario::take_shared<CapyRider>(scenario_val);
            let capy_soldier = test_scenario::take_shared<CapySoldier>(scenario_val);



           

            // check getters (capy general)
            let address_general = owner_address_capy_general(&capy_general);
            debug::print<address>(&address_general);

            let type_general = type_capy_general(&capy_general);
            debug::print<String>(&type_general);

            let type_id_general = type_id_capy_general(&capy_general);
            debug::print<u64>(&type_id_general);

            let name_general = name_capy_general(&capy_general);
            debug::print<String>(&name_general);

            let image_url_general = image_url_capy_general(&capy_general);
            debug::print<String>(&image_url_general);

            let attack_general = attack_capy_general(&capy_general);
            debug::print<u64>(&attack_general);

            let defense_general = defense_capy_general(&capy_general);
            debug::print<u64>(&defense_general);

            let health_general = health_capy_general(&capy_general);
            debug::print<u64>(&health_general);

            let cost_general = cost_capy_general(&capy_general);
            debug::print<u64>(&cost_general);


            // check getters (capy monster)
            let address_monster = owner_address_capy_monster(&capy_monster);
            debug::print<address>(&address_monster);

            let type_monster = type_capy_monster(&capy_monster);
            debug::print<String>(&type_monster);

            let type_id_monster = type_id_capy_monster(&capy_monster);
            debug::print<u64>(&type_id_monster);

            let name_monster = name_capy_monster(&capy_monster);
            debug::print<String>(&name_monster);

            let image_url_monster = image_url_capy_monster(&capy_monster);
            debug::print<String>(&image_url_monster);

            let attack_general = attack_capy_monster(&capy_monster);
            debug::print<u64>(&attack_general);

            let defense_monster = defense_capy_monster(&capy_monster);
            debug::print<u64>(&defense_monster);

            let health_monster = health_capy_monster(&capy_monster);
            debug::print<u64>(&health_monster);

            let cost_monster = cost_capy_monster(&capy_monster);
            debug::print<u64>(&cost_monster);



            // check getters (capy rider)
            let address_rider = owner_address_capy_rider(&capy_rider);
            debug::print<address>(&address_rider);

            let type_rider = type_capy_rider(&capy_rider);
            debug::print<String>(&type_rider);

            let type_id_rider = type_id_capy_rider(&capy_rider);
            debug::print<u64>(&type_id_rider);

            let name_rider = name_capy_rider(&capy_rider);
            debug::print<String>(&name_rider);

            let image_url_rider = image_url_capy_rider(&capy_rider);
            debug::print<String>(&image_url_rider);

            let attack_rider = attack_capy_rider(&capy_rider);
            debug::print<u64>(&attack_rider);

            let defense_rider = defense_capy_rider(&capy_rider);
            debug::print<u64>(&defense_rider);

            let health_rider = health_capy_rider(&capy_rider);
            debug::print<u64>(&health_rider);

            let cost_rider = cost_capy_rider(&capy_rider);
            debug::print<u64>(&cost_rider);




            // check getters (capy soldier)
            let address_soldier = owner_address_capy_soldier(&capy_soldier);
            debug::print<address>(&address_soldier);

            let type_soldier = type_capy_soldier(&capy_soldier);
            debug::print<String>(&type_soldier);

            let type_id_soldier = type_id_capy_soldier(&capy_soldier);
            debug::print<u64>(&type_id_soldier);

            let name_soldier = name_capy_soldier(&capy_soldier);
            debug::print<String>(&name_soldier);

            let image_url_soldier = image_url_capy_soldier(&capy_soldier);
            debug::print<String>(&image_url_soldier);

            let attack_soldier = attack_capy_soldier(&capy_soldier);
            debug::print<u64>(&attack_soldier);

            let defense_soldier = defense_capy_soldier(&capy_soldier);
            debug::print<u64>(&defense_soldier);

            let health_soldier = health_capy_soldier(&capy_soldier);
            debug::print<u64>(&health_soldier);

            let cost_soldier = cost_capy_soldier(&capy_soldier);
            debug::print<u64>(&cost_soldier);





            test_scenario::return_shared(capy_general);
            test_scenario::return_shared(capy_monster);
            test_scenario::return_shared(capy_rider);
            test_scenario::return_shared(capy_soldier);





            // delete the decks
            delete_all_capy_card_caps(capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap, test_scenario::ctx(scenario_val)); 



        };





        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            
            // create gnome deck and confirm it
            let (capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap) = mint_capy_cards(test_scenario::ctx(scenario_val));



            // get shared obj
            let capy_general = test_scenario::take_shared<CapyGeneral>(scenario_val);
            let capy_monster = test_scenario::take_shared<CapyMonster>(scenario_val);
            let capy_rider = test_scenario::take_shared<CapyRider>(scenario_val);
            let capy_soldier = test_scenario::take_shared<CapySoldier>(scenario_val);



           

            confirm_capy_deck(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val));




            // delete the decks
            delete_all_capy_card_caps(capy_general_owner_cap, capy_monster_owner_cap, capy_rider_owner_cap, capy_soldier_owner_cap, test_scenario::ctx(scenario_val)); 



        };















        test_scenario::end(scenario);



    }













}