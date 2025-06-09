require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = Post.create!(title: "Test Post", content: "Something insightful")
    @comment = @post.comments.create!(content: "Original comment")
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { content: "Great read!" } }
    end

    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "Comment added.", response.body
  end

  test "should not create invalid comment" do
    assert_no_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { content: "" } }
    end

    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "Comment can&#39;t be blank", response.body
  end

  test "should destroy comment" do
    comment = @post.comments.create!(content: "To be deleted")
    assert_difference("Comment.count", -1) do
      delete post_comment_url(@post, comment)
    end

    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "Comment deleted.", response.body
  end


  test "should get edit form for comment" do
    get edit_post_comment_url(@post, @comment)
    assert_response :success
    assert_match "Edit Comment", response.body
  end

  test "should update comment with valid content" do
    patch post_comment_url(@post, @comment), params: {
      comment: { content: "Updated comment" }
    }

    assert_redirected_to post_url(@post)
    follow_redirect!
    assert_match "Comment updated.", response.body
    assert_match "Updated comment", response.body
  end

  test "should not update comment with empty content" do
    patch post_comment_url(@post, @comment), params: {
      comment: { content: "" }
    }

    assert_response :unprocessable_entity
    assert_match "Content can&#39;t be blank", response.body
  end
end
