class ProfilesController < ApplicationController
  def new
    @profile = current_user.build_profile
    @profile.portfolios.build
  end

  def index
    @profiles = Profile.all.includes(:user).order(grade: :desc).order(name: :asc).page(params[:page]).per(18)
  end

  def show; end

  def edit; end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to @profile, success: 'プロフィールを作成しました'
    else
      flash.now['danger'] = '作成に失敗しました'
      render :new
    end
  end

  def update; end

  private

  def profile_params
    params.require(:profile).permit(:name, :grade, :gender, :birthplace_code, :living_place_code,
                                    :date_of_birth, :blood_type, :siblings_relation, :hobby,
                                    :times_name, :team_dev_will, :twitter_account, :self_introduce,
                                    :avatar, :avatar_cache,
                                    portfolios_attributes: %i[id profile_id name url status])
  end
end
