#[test_only]
module capy_vs_gnome::capy_vs_gnome_tests {


    use sui::test_scenario;
    use sui::test_utils::{create_one_time_witness, assert_eq};
    use std::debug;

    use capy_vs_gnome::character_cards::{CHARACTER_CARDS, init_for_testing, mint_gnome_army, mint_capy_army};
    use capy_vs_gnome::character_cards::{delete_gnome_general, delete_gnome_monster, delete_gnome_rider, delete_gnome_soldier};
    use capy_vs_gnome::character_cards::{delete_capy_general, delete_capy_monster, delete_capy_rider, delete_capy_soldier};




    fun init_test_helper() : test_scenario::Scenario {

        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = test_scenario::begin(admin);
        let scenario_val = &mut scenario;

        let otw = create_one_time_witness<CHARACTER_CARDS>();


        {
            init_for_testing(otw, test_scenario::ctx(scenario_val));
        };

        scenario



    }



    #[test]
    public fun random_nfts_tests() {


        let admin = @0xABC;
        let user1 = @0x123;

        let scenario = init_test_helper();
        let scenario_val = &mut scenario;


        // Test 1
        test_scenario::next_tx(scenario_val, admin);
        {

            let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_army(test_scenario::ctx(scenario_val));
            let (capy_general, capy_monster, capy_rider, capy_soldier) = mint_capy_army(test_scenario::ctx(scenario_val));


            delete_gnome_general(gnome_general);
            delete_gnome_monster(gnome_monster);
            delete_gnome_rider(gnome_rider);
            delete_gnome_soldier(gnome_soldier);


            delete_capy_general(capy_general);
            delete_capy_monster(capy_monster);
            delete_capy_rider(capy_rider);
            delete_capy_soldier(capy_soldier);


        };


        // Test 2
        test_scenario::next_tx(scenario_val, admin);
        {

        };


        test_scenario::end(scenario);



    }













}