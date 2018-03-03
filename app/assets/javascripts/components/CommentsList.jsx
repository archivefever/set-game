var CommentList = class CommentLister extends React.Component {
  constructor(props) {
    console.log(props);
    var message = JSON.parse(props.message);
    this.state = { message: message };
  }

  render() {
    var comments = this.state.message.comments.map(comment => {
      return this.renderComment(comment);
    });

    return <div>{comments}</div>;
  }

  renderComment(comment) {
    return (
      <article key={comment.id}>
        <h3>Comment by {comment.user.name}</h3>
        <p>{comment.content}</p>
      </article>
    );
  }
};

//   getInitialState(){
//     let message = JSON.parse(this.props.message);
//     return {message: message};
//   },

//   render() {
//     let comments = this.state.message.comments.map((comment) => {
//       return this.renderComment(comment);
//     });

//     return (
//       <div>{comments}</div>
//     );
//   },

//   renderComment(comment) {
//     return (
//       <article key={comment.id}>
//         <h3>Comment by { comment.user.name }</h3>
//         <p>{ comment.content }</p>
//       </article>
//     );
//   }
// });
