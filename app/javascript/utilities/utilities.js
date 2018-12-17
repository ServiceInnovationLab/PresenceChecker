const getCSRF = () => {
  const element = document.querySelector('meta[name="csrf-token"]');
  if (element) {
    return element.getAttribute('content');
  }
  return '';
};

const firstCharCap = str => str.charAt(0).toUpperCase() + str.slice(1);

const databaseURL = () =>
  process.env.NODE_ENV !== 'production'
    ? 'http://localhost:3000'
    : 'https://presence-prod.herokuapp.com/';

export { getCSRF, firstCharCap, databaseURL };
