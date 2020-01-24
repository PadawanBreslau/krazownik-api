class SignUpUserService
  attr_reader :user, :error_msg

  def initialize(params:)
    @params = params
    @error_msg = []
  end

  def call
    validate_email

    return false if @error_msg.present?

    create_user
    set_temporary_avatar
  end

  private

  def validate_email
    @error_msg << 'Email already taken' if email_taken?
    @error_msg << 'Email address not given' if blank_email?
  end

  def email_taken?
    User.find_by(email: @params[:email]&.downcase).present?
  end

  def blank_email?
    @params[:email].blank?
  end

  def create_user
    @user = User.new(@params)
    @user.save
  end

  def set_temporary_avatar
    @user.avatar.attach(io: File.open('public/avatar.png'), filename: 'avatar.png')
  end
end
