import React from 'react';
import ReactDOM from 'react-dom';

import './Quote.css';

export default React.createClass({
    propTypes: {
        id: React.PropTypes.number.isRequired,
        createdDate: React.PropTypes.object.isRequired,
        content: React.PropTypes.string.isRequired,
        upvotes: React.PropTypes.number.isRequired,
        downvotes: React.PropTypes.number.isRequired
    },

    render: function() {
        const content = this.props.content
            .split('\\n')
            .map((line, i) => <div key={i}>{line}</div>);

        return (
            <div className="Quote">
                <div className="Quote-header">
                    <span className="Quote-id">#{this.props.id}</span>
                    <div className="Quote-headerRight">
                        <span className="Quote-upvotes">{this.props.upvotes}</span>
                        <span className="Quote-downvotes">{this.props.downvotes}</span>
                        <span className="Quote-createdDate">{this.props.createdDate.format('MMM Do, YYYY')}</span>
                    </div>
                </div>
                <div className="Quote-content">
                    {content}
                </div>
            </div>
        );
    }
});
