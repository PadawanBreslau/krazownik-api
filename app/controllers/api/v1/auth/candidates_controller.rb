module Api
  module V1
    module Auth
      class CandidatesController < Api::V1::BaseController
        def sign_up
          sign_up_form = CandidateSignUpForm.new(candidate_params.to_h)
          if sign_up_form.valid?
            time_string = Time.current.to_s
            ::Auth::CandidateSignUpJob.perform_later(candidate_params.to_h, occured_at: time_string)
            render_success meta: { message: 'Invitation link will be sent if account exists.' }
          else
            render_error status: :unprocessable_entity,
                         title: 'Wrong data',
                         detail: sign_up_form.errors.full_messages.join(', ')
          end
        end

        private

        def candidate_params
          jsonapi_params.permit(
            :email, :first_name, :last_name, :phone, :terms
          )
        end
      end
    end
  end
end
