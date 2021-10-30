import Result "mo:base/Result";
import Cycles "mo:base/ExperimentalCycles";
import Bool "mo:base/Bool";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import ICP123CGPI "mo:icp123cgpi/ICP123CGPI";

shared ({caller = owner}) actor class ICP123Example() : async ICP123CGPI.ToUpInterface {



    type Metadata = ICP123CGPI.Metadata;

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
    public shared func icp123RegisterSelf(callback : ICP123CGPI.RegisterCallback) : async () {
        await callback({
            projectId = "ICP123";
            projectName = "ICP123 Example";
        });
    };


    private stable var _icp123cgpi : ?ICP123CGPI.ICP123CGPInterface = null;

    // Instantiate ICP123CGPICaniser
    public shared(msg) func setICP123CGPICaniserId(canisterId : Text) : async Bool {
        if (msg.caller != owner) {
            throw Error.reject("not authorized");
        };
        _icp123cgpi := ?actor(canisterId);
        true;
    };

    //To change in prod! 
    // let icp123cgpi : ICP123CGPI.ICP123CGPInterface = actor("rdmx6-jaaaa-aaaaa-aaadq-cai");


    // Register the current canister in ICP123DAO，After activation, it can be recharged by ICP123DAO
    public func register (project : Metadata) : async Result.Result<(), Text> {
        switch _icp123cgpi {
            case(?icp123cgpi) {
                let result = await icp123cgpi.registerCanister(project);
                result;
            };
            case(_) {
                #err("Register error, Not initialized ICP123CGPI canister")
            };
        };
        
    };

    
};
