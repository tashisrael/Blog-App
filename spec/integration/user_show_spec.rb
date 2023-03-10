require 'rails_helper'

RSpec.describe 'User Page Show', type: :feature do
  before :each do
    @tom = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 3
    )
    @post1 = Post.create(
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0,
      author_id: @tom.id
    )
    @post2 = Post.create(
      title: 'Greeting',
      text: 'hey you there',
      comments_counter: 0,
      likes_counter: 0,
      author_id: @tom.id
    )
    @post3 = Post.create(
      title: 'Going',
      text: 'i am availabler',
      comments_counter: 0,
      likes_counter: 1,
      author_id: @tom.id
    )
    visit user_path(@tom.id)
  end

  it 'shows the profile picture of the user' do
    assert page.has_xpath?("//img[@src = 'https://unsplash.com/photos/F_-0BxGuVvo'
     and @alt='user photo']")
  end

  it 'shows the username' do
    expect(page).to have_content(@tom.name)
  end

  it 'shows number of posts written by user' do
    expect(page).to have_content('Number of posts: 6')
  end

  it 'shows users bio' do
    expect(page).to have_content('Teacher from Mexico.')
  end

  it 'shows last three posts of user' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  it 'shows button for seeing all posts' do
    expect(page).to have_link('See all posts')
  end

  it 'redirects to post show page upon click' do
    click_on 'Hello'
    expect(page).to have_current_path user_post_path(@tom.id, @post1.id)
  end

  it 'redirects to user posts index page on click of see all post button' do
    click_link('See all posts')
    expect(page).to have_current_path user_posts_path(@tom.id)
  end
end
