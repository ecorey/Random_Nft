#[test_only]
module capy_vs_gnome::card_deck_tests_attacks {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;
    use std::vector;
    use sui::random::{Self, Random};
    use sui::tx_context::{Self, TxContext};
    use std::string::{Self, String};
    use capy_vs_gnome::card_deck::{CARD_DECK, init_for_testing};


    use capy_vs_gnome::card_deck::{Card, ConfirmedDeck};
    use capy_vs_gnome::card_deck::{gnome_deck, delete_all_gnome_cards};
    use capy_vs_gnome::card_deck::{capy_deck, delete_all_capy_cards};
    use capy_vs_gnome::card_deck::{confirm_deck_for_testing};

    use capy_vs_gnome::card_deck::{owner_address, type,  type_id, name,  image_url, attack, defense, health, cost};

    

    
    use capy_vs_gnome::card_deck::{general_vs_general};



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

        let random = @0x8;

        let scenario = init_test_helper();
        let scenario_val = &mut scenario;
        let ctx = test_scenario::ctx(scenario_val);


        

        

        // next test
        test_scenario::next_tx(scenario_val, admin);
        {
            // create gnome deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = gnome_deck(test_scenario::ctx(scenario_val));

            // create capy deck and confirm it
            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = confirm_deck_for_testing(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val));




            // print value
            let address_general_gnome = owner_address(&gnome_general);
            debug::print<address>(&address_general_gnome);









            // random::create_for_testing(test_scenario::ctx(scenario_val));

            // let random_state = test_scenario::take_shared<Random>(scenario_val);

        

            // test_scenario::return_shared(random_state);









            
            // delete the decks
            delete_all_gnome_cards(gnome_general, gnome_monster, gnome_rider, gnome_soldier, test_scenario::ctx(scenario_val)); 

            

        };










        // next test
        test_scenario::next_tx(scenario_val, user1);
        {
            let (capy_general, capy_monster, capy_rider, capy_soldier) = capy_deck(test_scenario::ctx(scenario_val));

            let (capy_general, capy_monster, capy_rider, capy_soldier) = confirm_deck_for_testing(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val));






                
            






            let address_general_capy = owner_address(&capy_general);
            debug::print<address>(&address_general_capy);





            let confirmed_deck = test_scenario::take_shared<ConfirmedDeck>(scenario_val);

            test_scenario::return_shared<ConfirmedDeck>(confirmed_deck);



            


            // general_vs_general(&random, capy_general, &confirmed_deck, capy_general, &confirmed_deck, test_scenario::ctx(scenario_val));


            delete_all_capy_cards(capy_general, capy_monster, capy_rider, capy_soldier, test_scenario::ctx(scenario_val)); 

            

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