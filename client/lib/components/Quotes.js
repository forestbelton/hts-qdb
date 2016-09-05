import React from 'react';
import ReactDOM from 'react-dom';
import moment from 'moment';
import 'whatwg-fetch';

import Quote from './Quote';
import Loading from './Loading';
import SortBy from '../data/SortBy';

export default React.createClass({
    propTypes: {
        quotes: React.PropTypes.arrayOf(
            React.PropTypes.shape({
                id: React.PropTypes.number.isRequired,
                createdDate: React.PropTypes.object.isRequired,
                content: React.PropTypes.string.isRequired,
                upvotes: React.PropTypes.number.isRequired,
                downvotes: React.PropTypes.number.isRequired
            })
        ),
        sortBy: React.PropTypes.instanceOf(SortBy).isRequired
    },

    getInitialState: function() {
        return {
            quotes: this.props.quotes
        };
    },

    componentDidMount: function() {
        if (typeof this.state.quotes == 'undefined') {
            const filter = this.props.sortBy.getName();

            fetch(`/quotes/${filter}`)
                .then(response => response.json())
                .then(quotes => this.setState({ quotes }));
        }
    },

    render: function() {
        if (typeof this.state.quotes == 'undefined') {
            return <Loading />;
        }

        const quotes = this.state.quotes
            .map((data, i) =>
                <Quote key={i} id={data.id} createdDate={moment(data.createdDate)}
                    content={data.content} upvotes={data.upvotes}
                    downvotes={data.downvotes} />
            );

        return <div>{quotes}</div>;
    }
});
