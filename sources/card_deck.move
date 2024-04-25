module capy_vs_gnome::card_deck {


    use sui::tx_context::{Self, TxContext};
    use sui::package::{Self, Publisher};
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::display::{Self, Display};
    use sui::event;
    use std::string::{utf8, String};
    use std::option::{Self, Option};
    use std::vector;
    use sui::clock::{Self, Clock};


    #[test_only]
    friend capy_vs_gnome::more_card_tests;

    // ----------------------------------------------
    // CHARACTER CARDS 
    // ----------------------------------------------
    
    // ----------------------------------------------
    // GNOMES
    // ----------------------------------------------


    struct GnomeGeneral has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability_one: String,
        ability_two: String,
    }

    fun mint_gnome_general(ctx: &mut TxContext) : GnomeGeneral {
        let id = object::new(ctx);

        GnomeGeneral {
            id: id,
            name: utf8(b"gnome general"),
            image_url: utf8(b"QmRuTsfxHrX7gofugKgVhpD2euscH2txkHXosEpvxGUMd8"),
            attack: 3,
            defense: 4,
            health: 6,
            cost: 4,
            ability_one: utf8(b"Rally"),
            ability_two: utf8(b"Defensive Orders"),
        }
    }


    fun transfer_gnome_general(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_general = GnomeGeneral {
            id: id,
            name: utf8(b"gnome general"),
            image_url: utf8(b"QmRuTsfxHrX7gofugKgVhpD2euscH2txkHXosEpvxGUMd8"),
            attack: 3,
            defense: 4,
            health: 6,
            cost: 4,
            ability_one: utf8(b"Rally"),
            ability_two: utf8(b"Defensive Orders"),
        };

        transfer::public_transfer(gnome_general, tx_context::sender(ctx));
    }


    public fun delete_gnome_general(gnome_general: GnomeGeneral) {
        let GnomeGeneral { id, name: _, image_url: _ , attack: _, defense: _, health: _, cost: _, ability_one: _, ability_two: _} = gnome_general;
        object::delete(id);
    }


    public fun delete_gnome_general_option(gnome_general: Option<GnomeGeneral>) {

         if (option::is_some(&gnome_general)) {
            let gnome_gen = option::extract(&mut gnome_general);
            delete_gnome_general(gnome_gen);
        };

        option::destroy_none(gnome_general);

    }   






    struct GnomeMonster has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }


    fun mint_gnome_monster(ctx: &mut TxContext) : GnomeMonster {
        let id = object::new(ctx);

        GnomeMonster {
            id: id,
            name: utf8(b"gnome monster"),
            image_url: utf8(b"Qme7gJPZoRYJ75hBTyQUJKpiYCBacVeBEo6saJqUw99NVd"),
            attack: 6,
            defense: 2,
            health: 5,
            cost: 5,
            ability: utf8(b"Fury Assault"),
        }
    }



    fun transfer_gnome_monster(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_monster = GnomeMonster {
            id: id,
            name: utf8(b"gnome monster"),
            image_url: utf8(b"Qme7gJPZoRYJ75hBTyQUJKpiYCBacVeBEo6saJqUw99NVd"),
            attack: 6,
            defense: 2,
            health: 5,
            cost: 5,
            ability: utf8(b"Fury Assault"),
        };

        transfer::public_transfer(gnome_monster, tx_context::sender(ctx));
    }


    public fun delete_gnome_monster(gnome_monster: GnomeMonster) {
        let GnomeMonster { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _ } = gnome_monster;
        object::delete(id);
    }



    public fun delete_gnome_monster_option(gnome_monster: Option<GnomeMonster>) {

         if (option::is_some(&gnome_monster)) {
            let gnome_mon = option::extract(&mut gnome_monster);
            delete_gnome_monster(gnome_mon);
        };

        option::destroy_none(gnome_monster);

    }





    struct GnomeRider has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    fun mint_gnome_rider(ctx: &mut TxContext) : GnomeRider {
        let id = object::new(ctx);

        GnomeRider {
            id: id,
            name: utf8(b"gnome rider"),
            image_url: utf8(b"QmYxYgTHBTs6u5yatgW8xxpD6NHVECypYUGaHRjzWr6BPG"),
            attack: 4,
            defense: 3,
            health: 4,
            cost: 3,
            ability: utf8(b"Lightning Strike"),
        }
    }


    fun transfer_gnome_rider(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_rider = GnomeRider {
            id: id,
            name: utf8(b"gnome rider"),
            image_url: utf8(b"QmYxYgTHBTs6u5yatgW8xxpD6NHVECypYUGaHRjzWr6BPG"),
            attack: 4,
            defense: 3,
            health: 4,
            cost: 3,
            ability: utf8(b"Lightning Strike"),
        };

        transfer::public_transfer(gnome_rider, tx_context::sender(ctx));
    }


    public fun delete_gnome_rider(gnome_rider: GnomeRider) {
            let GnomeRider { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = gnome_rider;
            object::delete(id);
    }


    public fun delete_gnome_rider_option(gnome_rider: Option<GnomeRider>) {

         if (option::is_some(&gnome_rider)) {
            let gnome_rid = option::extract(&mut gnome_rider);
            delete_gnome_rider(gnome_rid);
        };

        option::destroy_none(gnome_rider);

    }





    struct GnomeSoldier has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    fun mint_gnome_soldier(ctx: &mut TxContext) : GnomeSoldier {
        let id = object::new(ctx);

        GnomeSoldier {
            id: id,
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"QmXkTwHYLSbuVCErb1rXsnG3dcXwdzBU9fE6WNtFjx4fLG"),
            attack: 4,
            defense: 5,
            health: 5,
            cost: 3,
            ability: utf8(b"Shield Wall"),
        }
    }


    fun transfer_gnome_soldier(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let gnome_soldier = GnomeSoldier {
            id: id,
            name: utf8(b"gnome soldier"),
            image_url: utf8(b"QmXkTwHYLSbuVCErb1rXsnG3dcXwdzBU9fE6WNtFjx4fLG"),
            attack: 4,
            defense: 5,
            health: 5,
            cost: 3,
            ability: utf8(b"Shield Wall"),
        };

        transfer::public_transfer(gnome_soldier, tx_context::sender(ctx));
    }


    public fun delete_gnome_soldier(gnome_soldier: GnomeSoldier) {
        let GnomeSoldier { id, name: _, image_url: _ , attack: _, defense: _, health: _, cost: _, ability: _ } = gnome_soldier;
        object::delete(id);
    }


    public fun delete_gnome_soldier_option(gnome_soldier: Option<GnomeSoldier>) {

         if (option::is_some(&gnome_soldier)) {
            let gnome_sol = option::extract(&mut gnome_soldier);
            delete_gnome_soldier(gnome_sol);
        };

        option::destroy_none(gnome_soldier);

    }





    // ----------------------------------------------
    // CAPYBARAS
    // ----------------------------------------------


    struct CapyGeneral has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability_one: String,
        ability_two: String,
    }

    fun mint_capy_general(ctx: &mut TxContext) : CapyGeneral {
        let id = object::new(ctx);

        CapyGeneral {
            id: id,
            name: utf8(b"capy general"),
            image_url: utf8(b"QmcS4qBSBkzkFT7rVtmkFsnffAoi5bjtSA9DfEF4Y8ZRiT"),
            attack: 3,
            defense: 4,
            health: 6,
            cost: 4,
            ability_one: utf8(b"Rally"),
            ability_two: utf8(b"Defensive Orders"),
        }
    }


    fun transfer_capy_general(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_general = CapyGeneral {
            id: id,
            name: utf8(b"capy general"),
            image_url: utf8(b"QmcS4qBSBkzkFT7rVtmkFsnffAoi5bjtSA9DfEF4Y8ZRiT"),
            attack: 3,
            defense: 4,
            health: 6,
            cost: 4,
            ability_one: utf8(b"Rally"),
            ability_two: utf8(b"Defensive Orders"),
        };

        transfer::public_transfer(capy_general, tx_context::sender(ctx));
    }


    // delete functions for capy warriors
    public fun delete_capy_general(capy_general: CapyGeneral) {
        let CapyGeneral { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability_one: _, ability_two: _ } = capy_general;
        object::delete(id);
    }






    struct CapyMonster has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    fun mint_capy_monster(ctx: &mut TxContext) : CapyMonster {
        let id = object::new(ctx);

        CapyMonster {
            id: id,
            name: utf8(b"capy monster"),
            image_url: utf8(b"QmULsZAotb8iDhUjWXRzW8KjqA7RedY9QdNuQL19eMpjis"),
            attack: 6,
            defense: 2,
            health: 5,
            cost: 5,
            ability: utf8(b"Fury Assault"),
        }
    }


    fun transfer_capy_monster(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_monster = CapyMonster {
            id: id,
            name: utf8(b"capy monster"),
            image_url: utf8(b"QmULsZAotb8iDhUjWXRzW8KjqA7RedY9QdNuQL19eMpjis"),
            attack: 6,
            defense: 2,
            health: 5,
            cost: 5,
            ability: utf8(b"Fury Assault"),
        };

        transfer::public_transfer(capy_monster, tx_context::sender(ctx));
    }



    public fun delete_capy_monster(capy_monster: CapyMonster) {
        let CapyMonster { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = capy_monster;
        object::delete(id);
    }




    struct CapyRider has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }

    fun mint_capy_rider(ctx: &mut TxContext) : CapyRider {
        let id = object::new(ctx);

        CapyRider {
            id: id,
            name: utf8(b"capy rider"),
            image_url: utf8(b"QmZ6u3nvnArnrfTW7akBL9T2Afy2MzexfuP76EcZ8e575H"),
            attack: 4,
            defense: 3,
            health: 4,
            cost: 3,
            ability: utf8(b"Lightning Strike"),
        }
    }



    fun transfer_capy_rider(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_rider = CapyRider {
            id: id,
            name: utf8(b"capy rider"),
            image_url: utf8(b"QmZ6u3nvnArnrfTW7akBL9T2Afy2MzexfuP76EcZ8e575H"),
            attack: 4,
            defense: 3,
            health: 4,
            cost: 3,
            ability: utf8(b"Lightning Strike"),
        };

        transfer::public_transfer(capy_rider, tx_context::sender(ctx));
    }


    public fun delete_capy_rider(capy_rider: CapyRider) {
        let CapyRider { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = capy_rider;
        object::delete(id);
    }


    




    struct CapySoldier has key, store {
        id: UID,
        name: String, 
        image_url: String,
        attack: u64,
        defense: u64,
        health: u64,
        cost: u64,
        ability: String,
    }


    fun mint_capy_soldier(ctx: &mut TxContext) : CapySoldier {
        let id = object::new(ctx);

        CapySoldier {
            id: id,
            name: utf8(b"capy soldier"),
            image_url: utf8(b"QmYgEa5Rv3FussydF31tndCABWE7XxnLTtscUk7yHU4GCM"),
            attack: 4,
            defense: 5,
            health: 5,
            cost: 3,
            ability: utf8(b"Shield Wall"),
        }
    }


    fun transfer_capy_soldier(ctx: &mut TxContext) {
        let id = object::new(ctx);

        let capy_soldier = CapySoldier {
            id: id,
            name: utf8(b"capy soldier"),
            image_url: utf8(b"QmYgEa5Rv3FussydF31tndCABWE7XxnLTtscUk7yHU4GCM"),
            attack: 4,
            defense: 5,
            health: 5,
            cost: 3,
            ability: utf8(b"Shield Wall"),
        };

        transfer::public_transfer(capy_soldier, tx_context::sender(ctx));
    }


    public fun delete_capy_soldier(capy_soldier: CapySoldier) {
        let CapySoldier { id, name: _, image_url: _, attack: _, defense: _, health: _, cost: _, ability: _  } = capy_soldier;
        object::delete(id);
    }



    // ----------------------------------------------
    // ONE TIME USE POWER CARDS 
    // ----------------------------------------------

    
    // // DIVINE SHIELD *********************************
    // struct DivineShield has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_divine_shield( divine_shield: DivineShield, ctx: &mut TxContext) {


    //     // One character is immune to all damage and effects for one turn. (Cost: 5 CP)


    //     let DivineShield {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = divine_shield; 

    //     object::delete(id);

    // }


    // fun mint_divine_shield(ctx: &mut TxContext) : DivineShield {
    //     let id = object::new(ctx);

    //     DivineShield {
    //         id: id,
    //         name: utf8(b"divine shield"),
    //         image_url: utf8(b"QmbyA8xjAxZNfwdgGMhMDb5f2hSdQYM68kZJgGhKd6nnMz"),
    //     }
    // }


    
    // public fun delete_divine_shield(divine_shield: DivineShield) {
    //     let DivineShield { id, name: _, image_url: _ } = divine_shield;
    //     object::delete(id);
    // }

    

    // // LAST STAND *********************************
    // struct LastStand has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_last_stand( last_stand: LastStand, ctx: &mut TxContext) {


    //     // For one turn, your characters cannot be reduced below 1 health. (Cost: 5 CP)

    //     let LastStand {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = last_stand; 

    //     object::delete(id);

    // }


    // fun mint_last_stand(ctx: &mut TxContext) : LastStand {
    //     let id = object::new(ctx);

    //     LastStand {
    //         id: id,
    //         name: utf8(b"last stand"),
    //         image_url: utf8(b"Qmdq15cjatXJbuNt7rF2WM9gzb7JHbb3oexUhY1Gw4ncdy"),
    //     }
    // }


    
    // public fun delete_last_stand(last_stand: LastStand) {
    //     let LastStand { id, name: _, image_url: _ } = last_stand;
    //     object::delete(id);
    // }




    // // MASSIVE ONSLAUGHT *********************************
    // struct MassiveOnslaught has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_massive_onslaught( massive_onslaught: MassiveOnslaught, ctx: &mut TxContext) {


    //     // Your characters gain +3 attack for one turn. (Cost: 5 CP)
    //     let MassiveOnslaught {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = massive_onslaught; 

    //     object::delete(id);

    // }


    // fun mint_massive_onslaught(ctx: &mut TxContext) : MassiveOnslaught {
    //     let id = object::new(ctx);

    //     MassiveOnslaught {
    //         id: id,
    //         name: utf8(b"massive onslaught"),
    //         image_url: utf8(b"Qmf18nsatUr1Ei17aNLFAQ47uv9jW8ovCai9E9Luma1Wiv"),
    //     }
    // }


    
    // public fun delete_massive_onslaught(massive_onslaught: MassiveOnslaught) {
    //     let MassiveOnslaught { id, name: _, image_url: _ } = massive_onslaught;
    //     object::delete(id);
    // }







    // // ----------------------------------------------
    // // SPECIAL ACTIONS
    // // ----------------------------------------------

    // // BATTLE CRY **************************************
    // struct BattleCry has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_battle_cry( battle_cry: BattleCry, ctx: &mut TxContext) {


    //     // All your characters gain +1 attack for the turn. (Cost: 3 CP)

    //     let BattleCry {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = battle_cry; 

    //     object::delete(id);

    // }


    // fun mint_battle_cry(ctx: &mut TxContext) : BattleCry {
    //     let id = object::new(ctx);

    //     BattleCry {
    //         id: id,
    //         name: utf8(b"battle cry"),
    //         image_url: utf8(b"QmW3GBdKzxeHmuvym4pPNg6VHJuHsTFDEscoB97LXxon5G"),
    //     }
    // }


    
    // public fun delete_battle_cry(battle_cry: BattleCry) {
    //     let BattleCry { id, name: _, image_url: _ } = battle_cry;
    //     object::delete(id);
    // }




    // // DECISIVE STRIKE *********************************
    // struct DecisiveStrike has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_decisive_strike( decisive_strike: DecisiveStrike, ctx: &mut TxContext) {


    //     // Deal 3 damage directly to an enemy character; this damage bypasses normal defense calculations. (Cost: 4 CP)

    //     let DecisiveStrike {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = decisive_strike; 

    //     object::delete(id);

    // }


    // fun mint_decisive_strike(ctx: &mut TxContext) : DecisiveStrike {
    //     let id = object::new(ctx);

    //     DecisiveStrike {
    //         id: id,
    //         name: utf8(b"decisive strike"),
    //         image_url: utf8(b"QmZ9CiMeEEJRCo1K31CnQw1ELqq76Yh3r72eqHi7TkDKGw"),
    //     }
    // }


    
    // public fun delete_decisive_strike(decisive_strike: DecisiveStrike) {
    //     let DecisiveStrike { id, name: _, image_url: _ } = decisive_strike;
    //     object::delete(id);
    // }




    // // SHIELD BASH *************************************
    // struct ShieldBash has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_shield_bash( shield_bash: ShieldBash, ctx: &mut TxContext) {


    //     // If your character successfully defends against an attack, deal 2 damage to the attacker. (Cost: 2 CP)
    //     let ShieldBash {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = shield_bash; 

    //     object::delete(id);

    // }


    // fun mint_shield_bash(ctx: &mut TxContext) : ShieldBash {
    //     let id = object::new(ctx);

    //     ShieldBash {
    //         id: id,
    //         name: utf8(b"shield bash"),
    //         image_url: utf8(b"QmWfHkQL2hkTDmWAhe7DGmbU88QnFRw2ChzFKm2n2hHxt5"),
    //     }
    // }


    
    // public fun delete_shield_bash(shield_bash: ShieldBash) {
    //     let ShieldBash { id, name: _, image_url: _ } = shield_bash;
    //     object::delete(id);
    // }










    // // ----------------------------------------------
    // // STAT MODIFIERS
    // // ----------------------------------------------
    // // BOOST ATTACK **************************************
    // struct BoostAttack has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_boost_attack( boost_attack: BoostAttack, ctx: &mut TxContext) {


    //     // Temporarily increases a character's attack by +2 for one turn. (Cost: 2 CP)
    //     let BoostAttack {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = boost_attack; 

    //     object::delete(id);

    // }


    // fun mint_boost_attack(ctx: &mut TxContext) : BoostAttack {
    //     let id = object::new(ctx);

    //     BoostAttack {
    //         id: id,
    //         name: utf8(b"boost attack"),
    //         image_url: utf8(b"QmZiYuc9GCj7qaPMqJRb5NzuXwAF7NRngqxBVTSJtLAQZb"),
    //     }
    // }


    
    // public fun delete_boost_attack(boost_attack: BoostAttack) {
    //     let BoostAttack { id, name: _, image_url: _ } = boost_attack;
    //     object::delete(id);
    // }




    // // FORTIFY DEFENSE *********************************
    // struct FortifyDefense has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_fortify_defense( fortify_defense: FortifyDefense, ctx: &mut TxContext) {


    //     // Increases a character's defense by +2 until your next turn. (Cost: 2 CP)
    //     let FortifyDefense {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = fortify_defense; 

    //     object::delete(id);

    // }


    // fun mint_fortify_defense(ctx: &mut TxContext) : FortifyDefense {
    //     let id = object::new(ctx);

    //     FortifyDefense {
    //         id: id,
    //         name: utf8(b"fortify defense"),
    //         image_url: utf8(b"QmdJpA2xaj5WEbAWitW56z76LQvWJvYAVFgj7ctS2E5Pwh"),
    //     }
    // }


    
    // public fun delete_fortify_defense(fortify_defense: FortifyDefense) {
    //     let FortifyDefense { id, name: _, image_url: _ } = fortify_defense;
    //     object::delete(id);
    // }




    // // VITALITY SURGE ********************************
    // struct VitalitySurge has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_vitality_surge( vitality_surge: VitalitySurge, ctx: &mut TxContext) {


    //     // Immediately restore 3 health to a character. (Cost: 3 CP)
    //     let VitalitySurge {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = vitality_surge; 

    //     object::delete(id);

    // }


    // fun mint_vitality_surge(ctx: &mut TxContext) : VitalitySurge {
    //     let id = object::new(ctx);

    //     VitalitySurge {
    //         id: id,
    //         name: utf8(b"vitality surge"),
    //         image_url: utf8(b"QmSBKeHcxjkzNLAM1z8sohSwzrhN2ZjXwwMuUdhBKWmFP5"),
    //     }
    // }


    
    // public fun delete_vitality_surge(vitality_surge: VitalitySurge) {
    //     let VitalitySurge { id, name: _, image_url: _ } = vitality_surge;
    //     object::delete(id);
    // }










    // // ----------------------------------------------
    // // TACTICAL MOVES
    // // ----------------------------------------------

    // // AMBUSH **************************************
    // struct Ambush has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_ambush( ambush: Ambush, ctx: &mut TxContext) {


    //     // Play this card when an opponent declares an attack; your character gains +3 to defense for that combat. (Cost: 3 CP)

    //     let Ambush {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = ambush; 

    //     object::delete(id);

    // }


    // fun mint_ambush(ctx: &mut TxContext) : Ambush {
    //     let id = object::new(ctx);

    //     Ambush {
    //         id: id,
    //         name: utf8(b"ambush"),
    //         image_url: utf8(b"QmP15Ja7u7tE4VUrNCrmTnfvpq3SffoHTNK9SvRhSH6k2e"),
    //     }
    // }


    
    // public fun delete_ambush(ambush: Ambush) {
    //     let Ambush { id, name: _, image_url: _ } = ambush;
    //     object::delete(id);
    // }




    // // QUICK RETREAT *********************************
    // struct QuickRetreat has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_quick_retreat( quick_retreat: QuickRetreat, ctx: &mut TxContext) {


    //     // Move one of your characters to a reserve position, making it untargetable until the next turn. (Cost: 2 CP)
    //     let QuickRetreat {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = quick_retreat; 

    //     object::delete(id);

    // }


    // fun mint_quick_retreat(ctx: &mut TxContext) : QuickRetreat {
    //     let id = object::new(ctx);

    //     QuickRetreat {
    //         id: id,
    //         name: utf8(b"quick retreat"),
    //         image_url: utf8(b"QmcDZEL2kv1CuiUs19i23yHoiaGFyXzoqJ8VBZaNa51qoG"),
    //     }
    // }


    
    // public fun delete_quick_retreat(quick_retreat: QuickRetreat) {
    //     let QuickRetreat { id, name: _, image_url: _ } = quick_retreat;
    //     object::delete(id);
    // }




    // // REINFORCEMENTS *********************************
    // struct Reinforcements has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_reinforcements( reinforcements: Reinforcements, ctx: &mut TxContext) {


    //     // Draw two cards from your deck. (Cost: 2 CP)
    //     let Reinforcements {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = reinforcements; 

    //     object::delete(id);

    // }


    // fun mint_reinforcements(ctx: &mut TxContext) : Reinforcements {
    //     let id = object::new(ctx);

    //     Reinforcements {
    //         id: id,
    //         name: utf8(b"reinforcements"),
    //         image_url: utf8(b"QmQiyCzdZX2U134byPS8RWQVZTpQVHyzpB2Y9EpY3zp6gP"),
    //     }
    // }


    
    // public fun delete_reinforcements(reinforcements: Reinforcements) {
    //     let Reinforcements { id, name: _, image_url: _ } = reinforcements;
    //     object::delete(id);
    // }







    // // ----------------------------------------------
    // // STRATEGIC EFFECTS
    // // ----------------------------------------------

    // // PEACE TREATY ***********************************
    // struct PeaceTreaty has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_peace_treaty( peace_treaty: PeaceTreaty, ctx: &mut TxContext) {


    //     // Neither player can attack for the next turn. (Cost: 2 CP)
    //     let PeaceTreaty {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = peace_treaty; 

    //     object::delete(id);

    // }


    // fun mint_peace_treaty(ctx: &mut TxContext) : PeaceTreaty {
    //     let id = object::new(ctx);

    //     PeaceTreaty {
    //         id: id,
    //         name: utf8(b"peace treaty"),
    //         image_url: utf8(b"QmdmVfDUNuAutLCzEb2qML7fHCpJKvn58qcGTgNLcdU9FX"),
    //     }
    // }


    
    // public fun delete_peace_treaty(peace_treaty: PeaceTreaty) {
    //     let PeaceTreaty { id, name: _, image_url: _ } = peace_treaty;
    //     object::delete(id);
    // }




    // // SABOTAGE **************************************
    // struct Sabotage has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_sabotage( sabotage: Sabotage, ctx: &mut TxContext) {


    //     // Target opponent generates 2 less CP on their next turn. (Cost: 3 CP)
    //     let Sabotage {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = sabotage; 

    //     object::delete(id);

    // }


    // fun mint_sabotage(ctx: &mut TxContext) : Sabotage {
    //     let id = object::new(ctx);

    //     Sabotage {
    //         id: id,
    //         name: utf8(b"sabotage"),
    //         image_url: utf8(b"QmUpTEBV4wX5MEcRnCv6BL6oYYrcRZ4WPK2aq6QCkntU43"),
    //     }
    // }


    
    // public fun delete_sabotage(sabotage: Sabotage) {
    //     let Sabotage { id, name: _, image_url: _ } = sabotage;
    //     object::delete(id);
    // }




    // // WAR DRUMS *************************************
    // struct WarDrums has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_war_drums( war_drums: WarDrums, ctx: &mut TxContext) {


    //     // Increase the CP generation by 1 for the next two turns. (Cost: 4 CP)
    //     let WarDrums {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = war_drums; 

    //     object::delete(id);

    // }


    // fun mint_war_drums(ctx: &mut TxContext) : WarDrums {
    //     let id = object::new(ctx);

    //     WarDrums {
    //         id: id,
    //         name: utf8(b"war drums"),
    //         image_url: utf8(b"QmYQvueWZj2iTB7TE2ainaEsjyijApNusJatZUnWtcHepX"),
    //     }
    // }


    
    // public fun delete_war_drums(war_drums: WarDrums) {
    //     let WarDrums { id, name: _, image_url: _ } = war_drums;
    //     object::delete(id);
    // }









    // // ----------------------------------------------
    // // UTILITY CARDS
    // // ----------------------------------------------

    // // ESPIONAGE **************************************
    // struct Espionage has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_espionage( espionage: Espionage, ctx: &mut TxContext) {


    //     // Look at an opponent's hand, select one card they must discard. (Cost: 4 CP)
    //     let Espionage {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = espionage; 

    //     object::delete(id);

    // }


    // fun mint_espionage(ctx: &mut TxContext) : Espionage {
    //     let id = object::new(ctx);

    //     Espionage {
    //         id: id,
    //         name: utf8(b"espionage"),
    //         image_url: utf8(b"QmUqrhZu3GFB3XSR9jVUNdnZb3rENKR1ZuEGXeUMUjD683"),
    //     }
    // }


    
    // public fun delete_espionage(espionage: Espionage) {
    //     let Espionage { id, name: _, image_url: _ } = espionage;
    //     object::delete(id);
    // }




    // // REGROUP ***************************************
    // struct Regroup has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_regroup( regroup: Regroup, ctx: &mut TxContext) {


    //     // Shuffle up to three cards from your discard pile back into your deck. (Cost: 3 CP)
    //     let Regroup {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = regroup; 

    //     object::delete(id);

    // }


    // fun mint_regroup(ctx: &mut TxContext) : Regroup {
    //     let id = object::new(ctx);

    //     Regroup {
    //         id: id,
    //         name: utf8(b"regroup"),
    //         image_url: utf8(b"QmS2NR8uVd3gHMPXj2F7Nj4sgQCPa4WnpBiqaugYVsYwdz"),
    //     }
    // }


    
    // public fun delete_regroup(regroup: Regroup) {
    //     let Regroup { id, name: _, image_url: _ } = regroup;
    //     object::delete(id);
    // }




    // // SCOUT *****************************************
    // struct Scout has key, store {
    //     id: UID,
    //     name: String, 
    //     image_url: String,
    // }


    // // when card is played it is lost, and the effect is applied to the player's character
    // public fun use_scout( scout: Scout, ctx: &mut TxContext) {


    //     // Shuffle up to three cards from your discard pile back into your deck. (Cost: 3 CP)
    //     let Scout {
    //         id,
    //         name: _,
    //         image_url: _,
        
    //     } = scout; 

    //     object::delete(id);

    // }


    // fun mint_scout(ctx: &mut TxContext) : Scout {
    //     let id = object::new(ctx);

    //     Scout {
    //         id: id,
    //         name: utf8(b"scout"),
    //         image_url: utf8(b"QmQX6vo2GviSJp3wXzLP56SLPL8vsMmqSN7sPDpJDTVYQT"),
    //     }
    // }


    
    // public fun delete_scout(scout: Scout) {
    //     let Scout { id, name: _, image_url: _ } = scout;
    //     object::delete(id);
    // }

    




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



        // divine shield
        // let divine_shield_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let divine_shield_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];


        // // last stand
        // let last_stand_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let last_stand_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // massive onslaught
        // let massive_onslaught_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let massive_onslaught_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // battle cry
        // let battle_cry_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let battle_cry_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // decisive strike
        // let decisive_strike_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let decisive_strike_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // shield bash
        // let shield_bash_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let shield_bash_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // boost attack
        // let boost_attack_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let boost_attack_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // fortify defense
        // let fortify_defense_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let fortify_defense_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // vitality surge
        // let vitality_surge_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let vitality_surge_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // ambush
        // let ambush_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let ambush_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // quick retreat
        // let quick_retreat_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let quick_retreat_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // reinforcements
        // let reinforcements_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let reinforcements_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // peace treaty
        // let peace_treaty_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let peace_treaty_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // sabotage
        // let sabotage_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let sabotage_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // war drums
        // let war_drums_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let war_drums_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // espionage
        // let espionage_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let espionage_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // regroup
        // let regroup_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let regroup_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];
        // // scout
        // let scout_keys = vector[
        //     utf8(b"name"),
        //     utf8(b"link"),
        //     utf8(b"image_url"),
        //     utf8(b"description"),
        //     utf8(b"project_url"),
        //     utf8(b"creator"),
        // ];

        // let scout_values = vector[
        //     utf8(b"{name}"),
        //     utf8(b"https://capy-vs-gnome.xyz/warrior/{id}"),
        //     utf8(b"ipfs://{image_url}"),
        //     utf8(b"capy vs. gnome"),
        //     utf8(b"https://capy-vs-gnome.xyz"),
        //     utf8(b"unk"),
        // ];




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




        // // divine shield
        // let display_divine_shield = display::new_with_fields<DivineShield>(
        //     &publisher, divine_shield_keys, divine_shield_values, ctx
        // );

        // display::update_version(&mut display_divine_shield);


        // // last stand
        // let display_last_stand = display::new_with_fields<LastStand>(
        //     &publisher, last_stand_keys, last_stand_values, ctx
        // );

        // display::update_version(&mut display_last_stand);

        // // massive onslaught
        // let display_massive_onslaught = display::new_with_fields<MassiveOnslaught>(
        //     &publisher, massive_onslaught_keys, massive_onslaught_values, ctx
        // );

        // display::update_version(&mut display_massive_onslaught);
        
        // // battle cry
        // let display_battle_cry = display::new_with_fields<BattleCry>(
        //     &publisher, battle_cry_keys, battle_cry_values, ctx
        // );

        // display::update_version(&mut display_battle_cry);

        // // decisive strike
        // let display_decisive_strike = display::new_with_fields<DecisiveStrike>(
        //     &publisher, decisive_strike_keys, decisive_strike_values, ctx
        // );

        // display::update_version(&mut display_decisive_strike);

        // // shield bash
        // let display_shield_bash = display::new_with_fields<ShieldBash>(
        //     &publisher, shield_bash_keys, shield_bash_values, ctx
        // );

        // display::update_version(&mut display_shield_bash);

        // // boost attack
        // let display_boost_attack = display::new_with_fields<BoostAttack>(
        //     &publisher, boost_attack_keys, boost_attack_values, ctx
        // );

        // display::update_version(&mut display_boost_attack);

        // // fortify defense
        // let display_fortify_defense = display::new_with_fields<FortifyDefense>(
        //     &publisher, fortify_defense_keys, fortify_defense_values, ctx
        // );

        // display::update_version(&mut display_fortify_defense);

        // // vitality surge
        // let display_vitality_surge = display::new_with_fields<VitalitySurge>(
        //     &publisher, vitality_surge_keys, vitality_surge_values, ctx
        // );

        // display::update_version(&mut display_vitality_surge);

        // // ambush
        // let display_ambush= display::new_with_fields<Ambush>(
        //     &publisher, ambush_keys, ambush_values, ctx
        // );

        // display::update_version(&mut display_ambush);

        // // quick retreat
        // let display_quick_retreat= display::new_with_fields<QuickRetreat>(
        //     &publisher, quick_retreat_keys, quick_retreat_values, ctx
        // );

        // display::update_version(&mut display_quick_retreat);

        // // reinforcements
        // let display_reinforcements = display::new_with_fields<Reinforcements>(
        //     &publisher, reinforcements_keys, reinforcements_values, ctx
        // );

        // display::update_version(&mut display_reinforcements);

        // // peace treaty
        // let display_peace_treaty = display::new_with_fields<PeaceTreaty>(
        //     &publisher, peace_treaty_keys, peace_treaty_values, ctx
        // );

        // display::update_version(&mut display_peace_treaty);

        // // sabotage
        // let display_sabotage = display::new_with_fields<Sabotage>(
        //     &publisher, sabotage_keys, sabotage_values, ctx
        // );

        // display::update_version(&mut display_sabotage);
        
        // // war drums
        // let display_war_drums = display::new_with_fields<WarDrums>(
        //     &publisher, war_drums_keys, war_drums_values, ctx
        // );

        // display::update_version(&mut display_war_drums);

        // // espionage
        // let display_espionage = display::new_with_fields<Espionage>(
        //     &publisher, espionage_keys, espionage_values, ctx
        // );

        // display::update_version(&mut display_espionage);

        // // regroup
        // let display_regroup = display::new_with_fields<Regroup>(
        //     &publisher, regroup_keys, regroup_values, ctx
        // );

        // display::update_version(&mut display_regroup);

        // // scout
        // let display_scout= display::new_with_fields<Scout>(
        //     &publisher, scout_keys, scout_values, ctx
        // );

        // display::update_version(&mut display_scout);



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
        
        // divine shield
        // transfer::public_transfer(display_divine_shield, tx_context::sender(ctx));
        
        // // last stand
        // transfer::public_transfer(display_last_stand, tx_context::sender(ctx));
        
        // // massive onslaught
        // transfer::public_transfer(display_massive_onslaught, tx_context::sender(ctx));

        // // battle cry
        // transfer::public_transfer(display_battle_cry, tx_context::sender(ctx));

        // // decisive strike
        // transfer::public_transfer(display_decisive_strike, tx_context::sender(ctx));

        // // shield bash
        // transfer::public_transfer(display_shield_bash, tx_context::sender(ctx));

        // // boost attack
        // transfer::public_transfer(display_boost_attack, tx_context::sender(ctx));

        // // fortify defense
        // transfer::public_transfer(display_fortify_defense, tx_context::sender(ctx));

        // // vitality surge
        // transfer::public_transfer(display_vitality_surge, tx_context::sender(ctx));

        // // ambush
        // transfer::public_transfer(display_ambush, tx_context::sender(ctx));

        // // quick retreat
        // transfer::public_transfer(display_quick_retreat, tx_context::sender(ctx));

        // // reinforcements
        // transfer::public_transfer(display_reinforcements, tx_context::sender(ctx));

        // // peace treaty
        // transfer::public_transfer(display_peace_treaty, tx_context::sender(ctx));

        // // sabotage
        // transfer::public_transfer(display_sabotage, tx_context::sender(ctx));

        // // war drums
        // transfer::public_transfer(display_war_drums, tx_context::sender(ctx));

        // // espionage
        // transfer::public_transfer(display_espionage, tx_context::sender(ctx));

        // // regroup
        // transfer::public_transfer(display_regroup, tx_context::sender(ctx));

        // // scout
        // transfer::public_transfer(display_scout, tx_context::sender(ctx));


    }



    // ----------------------------------------------
    

    // struct GnomeDeck has key, store {
    //     id: UID,
    //     gnome_general: Option<GnomeGeneral>,
    //     gnome_monster: Option<GnomeMonster>,
    //     gnome_rider: Option<GnomeRider>,
    //     gnome_soldier: Option<GnomeSoldier>,

        

    // }







    // struct CapyDeck has key, store {
    //     id: UID,
    //     capy_general: vector<CapyGeneral>,
    //     capy_monster: vector<CapyMonster>,
    //     capy_rider: vector<CapyRider>,
    //     capy_soldier: vector<CapySoldier>,
        
    // }








    // ----------------------------------------------





    // MINT DECKS
    // public fun mint_main_deck_cards(ctx: &mut TxContext) : (DivineShield, DivineShield, LastStand, LastStand, MassiveOnslaught, MassiveOnslaught, BattleCry, BattleCry, DecisiveStrike, DecisiveStrike, ShieldBash, ShieldBash, BoostAttack, BoostAttack, FortifyDefense, FortifyDefense, VitalitySurge, VitalitySurge, Ambush, Ambush, QuickRetreat, QuickRetreat, Reinforcements, Reinforcements, PeaceTreaty, PeaceTreaty, Sabotage, Sabotage, WarDrums, WarDrums, Espionage, Espionage, Regroup, Regroup, Scout, Scout) {  

    //     let divine_shield = mint_divine_shield(ctx);
    //     let divine_shield_two = mint_divine_shield(ctx);

    //     let last_stand = mint_last_stand(ctx);
    //     let last_stand_two = mint_last_stand(ctx);

    //     let massive_onslaught = mint_massive_onslaught(ctx);
    //     let massive_onslaught_two = mint_massive_onslaught(ctx);

    //     let battle_cry = mint_battle_cry(ctx);
    //     let battle_cry_two = mint_battle_cry(ctx);

    //     let decisive_strike = mint_decisive_strike(ctx);
    //     let decisive_strike_two = mint_decisive_strike(ctx);

    //     let shield_bash = mint_shield_bash(ctx);
    //     let shield_bash_two = mint_shield_bash(ctx);

    //     let boost_attack = mint_boost_attack(ctx);
    //     let boost_attack_two = mint_boost_attack(ctx);

    //     let fortify_defense = mint_fortify_defense(ctx);
    //     let fortify_defense_two = mint_fortify_defense(ctx);

    //     let vitality_surge = mint_vitality_surge(ctx);
    //     let vitality_surge_two = mint_vitality_surge(ctx);

    //     let ambush = mint_ambush(ctx);
    //     let ambush_two = mint_ambush(ctx);

    //     let quick_retreat = mint_quick_retreat(ctx);
    //     let quick_retreat_two = mint_quick_retreat(ctx);

    //     let reinforcements = mint_reinforcements(ctx);
    //     let reinforcements_two = mint_reinforcements(ctx);

    //     let peace_treaty = mint_peace_treaty(ctx);
    //     let peace_treaty_two = mint_peace_treaty(ctx);

    //     let sabotage = mint_sabotage(ctx);
    //     let sabotage_two = mint_sabotage(ctx);

    //     let war_drums = mint_war_drums(ctx);
    //     let war_drums_two = mint_war_drums(ctx);

    //     let espionage = mint_espionage(ctx);
    //     let espionage_two = mint_espionage(ctx);

    //     let regroup = mint_regroup(ctx);
    //     let regroup_two = mint_regroup(ctx);

    //     let scout = mint_scout(ctx);
    //     let scout_two = mint_scout(ctx);


    //     (divine_shield, divine_shield_two, last_stand, last_stand_two, massive_onslaught, massive_onslaught_two, battle_cry, battle_cry_two, decisive_strike, decisive_strike_two, shield_bash, shield_bash_two, boost_attack, boost_attack_two, fortify_defense, fortify_defense_two, vitality_surge, vitality_surge_two, ambush, ambush_two, quick_retreat, quick_retreat_two, reinforcements, reinforcements_two, peace_treaty, peace_treaty_two, sabotage, sabotage_two, war_drums, war_drums_two, espionage, espionage_two, regroup, regroup_two, scout, scout_two)

    
        
    // } 



     // GNOME DECK

    public fun mint_gnome_cards(ctx: &mut TxContext) : (GnomeGeneral, GnomeMonster, GnomeRider, GnomeSoldier) {

        
        
        let gnome_general = mint_gnome_general(ctx);
        let gnome_monster = mint_gnome_monster(ctx);
        let gnome_rider = mint_gnome_rider(ctx);
        let gnome_soldier = mint_gnome_soldier(ctx);
      


        (gnome_general, gnome_monster, gnome_rider, gnome_soldier)      


    } 
    



    public fun transfer_gnome_cards(ctx: &mut TxContext) {
            
            let gnome_general = mint_gnome_general(ctx);
            let gnome_monster = mint_gnome_monster(ctx);
            let gnome_rider = mint_gnome_rider(ctx);
            let gnome_soldier = mint_gnome_soldier(ctx);
    
            transfer::public_transfer(gnome_general, tx_context::sender(ctx));
            transfer::public_transfer(gnome_monster, tx_context::sender(ctx));
            transfer::public_transfer(gnome_rider, tx_context::sender(ctx));
            transfer::public_transfer(gnome_soldier, tx_context::sender(ctx));

    }







    public fun gnome_deck(ctx: &mut TxContext) : (GnomeGeneral, GnomeMonster, GnomeRider, GnomeSoldier) {


        let (gnome_general, gnome_monster, gnome_rider, gnome_soldier) = mint_gnome_cards(ctx);
        // let (divine_shield, divine_shield_two, 
        // last_stand, last_stand_two, 
        // massive_onslaught, massive_onslaught_two, 
        // battle_cry, battle_cry_two, 
        // decisive_strike, decisive_strike_two, 
        // shield_bash, shield_bash_two, 
        // boost_attack, boost_attack_two, 
        // fortify_defense, fortify_defense_two, 
        // vitality_surge, vitality_surge_two, 
        // ambush, ambush_two, 
        // quick_retreat, quick_retreat_two, 
        // reinforcements, reinforcements_two, 
        // peace_treaty, peace_treaty_two, 
        // sabotage, sabotage_two, 
        // war_drums, war_drums_two, 
        // espionage, espionage_two, 
        // regroup, regroup_two, 
        // scout, scout_two)
        // = mint_main_deck_cards(ctx);



        
        (gnome_general, gnome_monster, gnome_rider, gnome_soldier)
        //  divine_shield, divine_shield_two, 
        //  last_stand, last_stand_two, 
        //  massive_onslaught, massive_onslaught_two, 
        //  battle_cry, battle_cry_two, 
        //  decisive_strike, decisive_strike_two, 
        //  shield_bash, shield_bash_two, 
        //  boost_attack, boost_attack_two, 
        //  fortify_defense, fortify_defense_two, 
        //  vitality_surge, vitality_surge_two, 
        //  ambush, ambush_two, 
        //  quick_retreat, quick_retreat_two, 
        //  reinforcements, reinforcements_two, 
        //  peace_treaty, peace_treaty_two, 
        //  sabotage, sabotage_two, 
        //  war_drums, war_drums_two, 
        //  espionage, espionage_two, 
        //  regroup, regroup_two, 
        //  scout, scout_two)


    }



    public fun delete_all_gnome_cards(gnome_general: GnomeGeneral, gnome_monster: GnomeMonster, gnome_rider: GnomeRider, gnome_soldier: GnomeSoldier, ctx: &mut TxContext) {
        
        delete_gnome_general(gnome_general);
        delete_gnome_monster(gnome_monster);
        delete_gnome_rider(gnome_rider);
        delete_gnome_soldier(gnome_soldier);

        // delete_divine_shield(divine_shield);
        // delete_divine_shield(divine_shield_two);
        // delete_last_stand(last_stand);
        // delete_last_stand(last_stand_two);
        // delete_massive_onslaught(massive_onslaught);
        // delete_massive_onslaught(massive_onslaught_two);
        // delete_battle_cry(battle_cry);
        // delete_battle_cry(battle_cry_two);
        // delete_decisive_strike(decisive_strike);
        // delete_decisive_strike(decisive_strike_two);
        // delete_shield_bash(shield_bash);
        // delete_shield_bash(shield_bash_two);
        // delete_boost_attack(boost_attack);
        // delete_boost_attack(boost_attack_two);
        // delete_fortify_defense(fortify_defense);
        // delete_fortify_defense(fortify_defense_two);
        // delete_vitality_surge(vitality_surge);
        // delete_vitality_surge(vitality_surge_two);
        // delete_ambush(ambush);
        // delete_ambush(ambush_two);
        // delete_quick_retreat(quick_retreat);
        // delete_quick_retreat(quick_retreat_two);
        // delete_reinforcements(reinforcements);
        // delete_reinforcements(reinforcements_two);
        // delete_peace_treaty(peace_treaty);
        // delete_peace_treaty(peace_treaty_two);
        // delete_sabotage(sabotage);
        // delete_sabotage(sabotage_two);
        // delete_war_drums(war_drums);
        // delete_war_drums(war_drums_two);
        // delete_espionage(espionage);
        // delete_espionage(espionage_two);
        // delete_regroup(regroup);
        // delete_regroup(regroup_two);
        // delete_scout(scout);
        // delete_scout(scout_two);

    }


    // mint with Option
    // public fun mint_complete_gnome_deck(ctx: &mut TxContext) {
        
        
    //     // Mint gnome cards
    //     let (gnome_general_minted, gnome_monster_minted, gnome_rider_minted, gnome_soldier) = mint_gnome_cards(ctx);


    

    //     let gnome_deck = GnomeDeck {
    //         id: object::new(ctx),
    //         gnome_general: option::none(),
    //         gnome_monster: option::none(),
    //         gnome_rider: option::none(),
    //         gnome_soldier: option::none(),

    //     };


    //     option::fill<GnomeGeneral>(&mut gnome_deck.gnome_general, gnome_general_minted);
    //     option::fill<GnomeMonster>(&mut gnome_deck.gnome_monster, gnome_monster_minted);
    //     option::fill<GnomeRider>(&mut gnome_deck.gnome_rider, gnome_rider_minted);
    //     option::fill<GnomeSoldier>(&mut gnome_deck.gnome_soldier, gnome_soldier);


    //     transfer::public_transfer(gnome_deck, tx_context::sender(ctx));


    
    // }





    // public fun delete_complete_gnome_deck(deck: GnomeDeck) {

    //     let GnomeDeck {

    //         id, 
    //         gnome_general,
    //         gnome_monster,
    //         gnome_rider,
    //         gnome_soldier,

           

    //     } = deck;  



       
    //     delete_gnome_general_option(gnome_general);
    //     delete_gnome_monster_option(gnome_monster);
    //     delete_gnome_rider_option(gnome_rider);
    //     delete_gnome_soldier_option(gnome_soldier);

    //     object::delete(id);


       

    // }

    








  
    // CAPY DECK
    // public fun mint_capy_cards(ctx: &mut TxContext) : CapyDeck {
 
        
    // }


    public fun transfer_capy_cards(ctx: &mut TxContext) {

        let capy_general = mint_capy_general(ctx);
        let capy_monster = mint_capy_monster(ctx);
        let capy_rider = mint_capy_rider(ctx);
        let capy_soldier = mint_capy_soldier(ctx);

        transfer::public_transfer(capy_general, tx_context::sender(ctx));
        transfer::public_transfer(capy_monster, tx_context::sender(ctx));
        transfer::public_transfer(capy_rider, tx_context::sender(ctx));
        transfer::public_transfer(capy_soldier, tx_context::sender(ctx));

    }




    // public fun delete_capy_deck(deck: CapyDeck) {


    // }






    




    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------------------




    // GAME SETUP



    struct Player has key, store{
        id: UID,
        // game_deck: Option<>,
        // extra_cards: Option<>,
    }


    struct Game has key, store {
        id: UID,
        player_one: Player,
        player_two: Player,
    }


    // event to get time from a timestamp_ms
    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64
    }




    public fun game_setup(player_one: Player, player_two: Player, ctx: &mut TxContext) : Game {

        // assert!(player_one.game_deck == length(40));
        // assert!(player_two.game_deck == length(40));

        // assert that the player deck has each of the neeedd cards and appropriate number
        // assert!(player_one.game_deck );

        let game = Game {
            id: object::new(ctx),
            player_one,
            player_two,
        };

        game

    }




    public fun get_time(clock: &Clock)  {
        event::emit(TimeEvent {
            timestamp_ms: clock::timestamp_ms(clock),
        });

    }






    


























    #[test_only]
    public fun init_for_testing(otw: CARD_DECK, ctx: &mut TxContext) {
        init(otw, ctx);
    }





}




