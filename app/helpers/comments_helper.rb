module CommentsHelper

  def nested_comments(comment)
    "<%
    return if Comment.find_by_comment_parent_id(comment.id).empty?

    Comment.find_by_comment_parent_id(comment.id).each do |child|
      %><quote><%= child.content %></quote><%
      nested_comments(child)

    end%>".html_safe
  end
end
