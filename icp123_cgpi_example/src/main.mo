import Result "mo:base/Result";
import ICP123CGPI "mo:icp123car/ICP123CGPI";

shared ({caller = owner}) actor class ICP123CRD() : async ICP123CGPI.ToUpInterface {
    

   

    // private var _likesMap = HashMap.HashMap<Principal, Bool>(1, Principal.equal, Principal.hash);



    /**
    *   returns the canister cycles balance
    *   
    */
    public shared (msg) func canisterBalance(): async Nat {
        return Cycles.balance()
    };


    /**
    *   accept all canisters cycles top-up
    *   
    */
    public shared (msg) func topUp(): async Nat {
        let available = Cycles.available();
        Debug.print(debug_show("topUp::available()", available));
        let accepted = Cycles.accept(available);
        Debug.print(debug_show("topUp::accepted()", accepted));
        return Cycles.balance();
    };

    // REQUIRED function to integrate with ICP123.
    // ICP123 will call this function when registering your canister, or when requesting updated metadata.
    public shared func metascoreRegisterSelf(callback : Metascore.RegisterCallback) : async () {
        await callback({
            projectId = "icp123";
            projectName = "ICP123";
        });
    };
    
};
