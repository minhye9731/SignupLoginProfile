//
//  ProfileViewModel.swift
//  SignupLoginProfile
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel: CommonViewModel {
    
    // MARK: - property
    let profile = PublishSubject<Profile>()
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
    }
    
    // MARK: - functions
    func transform(input: Input) -> Output {
        return Output(tap: input.tap)
    }
    
    func getProfile() {
        let api = APIRouter.profile
        Network.share.requestSeSAC(type: Profile.self, router: api) { [weak self] response in
            
            switch response {
            case .success(let success):
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
    }
}
