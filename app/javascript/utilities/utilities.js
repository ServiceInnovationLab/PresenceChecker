const getCSRF = () => {
  let element = document.querySelector('meta[name="csrf-token"]');
  if (element) {
    return element.getAttribute('content');
  }
  return '';
};

const firstCharCap = str => str.charAt(0).toUpperCase() +
str.slice(1);

export { getCSRF, firstCharCap };
