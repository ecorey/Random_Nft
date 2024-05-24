module capy_vs_gnome::random_funcs {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::event;
    use std::string::{utf8, String};
    use sui::random::{Self, Random, new_generator};



    #[test_only]
    // friend capy_vs_gnome::random_funcs_tests;
    friend capy_vs_gnome::card_deck;





    // CONTENTS:
    //    - arithmetic_is_less_than









    struct RANDOM_FUNCS has drop {}




    fun init(otw: RANDOM_FUNCS, ctx: &mut TxContext) {


    }



    
    // Returns 1 if true, 0 false.
    // Safe in case w and v_max are independent of the randomenss (e.g., fixed).
    // Does not check if v <= v_max.
    public fun arithmetic_is_less_than(v: u8, w: u8, v_max: u8): u8 {
        assert!(v_max >= w && w > 0, 1);
        let v_max_over_w = v_max / w;
        let v_over_w = v / w; // 0 if v < w, [1, v_max_over_w] if above
        (v_max_over_w - v_over_w) / v_max_over_w
    }






    #[test_only]
    public fun init_for_testing(otw: RANDOM_FUNCS, ctx: &mut TxContext) {
        init(otw, ctx);
    }







}