class Users::NewUserFlow
    include Interactor::Organizer

    organize Users::CreateNewUser,
             Users::BroadcastUserAppearance
end